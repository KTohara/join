# == Schema Information
#
# Table name: likes
#
#  id            :bigint           not null, primary key
#  likeable_type :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  likeable_id   :bigint
#  user_id       :bigint           not null
#
# Indexes
#
#  index_likes_on_likeable                                   (likeable_type,likeable_id)
#  index_likes_on_user_id                                    (user_id)
#  index_likes_on_user_id_and_likeable_type_and_likeable_id  (user_id,likeable_type,likeable_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Like < ApplicationRecord
  include ActionView::RecordIdentifier

  belongs_to :user
  belongs_to :likeable, polymorphic: true, counter_cache: :like_count

  has_many :notifications, as: :notifiable, dependent: :destroy

  validates :user, presence: true, uniqueness: { scope: %i[likeable_id likeable_type] }

  after_create_commit do
    broadcast_update_to_like_counter
  end

  after_destroy_commit do
    broadcast_update_to_like_counter
  end

  private

  def broadcast_update_to_like_counter
    broadcast_replace_to likeable,
      target: dom_id(likeable, :like_count),
      partial: 'likes/like_counter',
      locals: { likeable: likeable }
  end
end
