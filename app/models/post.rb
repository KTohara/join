# == Schema Information
#
# Table name: posts
#
#  id            :bigint           not null, primary key
#  body          :text             not null
#  comment_count :integer          default(0)
#  like_count    :integer          default(0)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  author_id     :bigint
#  user_id       :bigint           not null
#
# Indexes
#
#  index_posts_on_author_id  (author_id)
#  index_posts_on_user_id    (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (author_id => users.id)
#  fk_rails_...  (user_id => users.id)
#
class Post < ApplicationRecord
  belongs_to :user
  belongs_to :author, class_name: 'User'

  has_many :comments, -> { includes(:user) },
           as: :commentable,
           dependent: :destroy

  has_many :likes, as: :likeable, dependent: :destroy

  validates :body, presence: true, length: { maximum: 15_000 }

  def formatted_date
    return if created_at.nil?

    created_at.strftime('%B %e')
  end
end
