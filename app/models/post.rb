# == Schema Information
#
# Table name: posts
#
#  id            :bigint           not null, primary key
#  body          :text             not null
#  comment_count :integer          default(0)
#  gif_url       :string
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

  has_one_attached :image, dependent: :destroy do |attachable|
    attachable.variant :display, resize_to_limit: [1200, 630]
  end

  has_many :comments, -> { order(created_at: :asc) },
           as: :commentable,
           dependent: :destroy
  
  has_many :likes, as: :likeable, dependent: :destroy

  validates :body, presence: true, unless: proc { |post| post.image.attached? }
  validates :body, length: { maximum: 15_000 }
                   
  validates :image, content_type: { in: %w[image/png image/jpg image/jpeg image/gif], message: 'image must be a valid format' },
                    size: { less_than: 5.megabytes, message: 'image must be less than 5MB' }

  def parent_comments
    comments.where(parent_id: nil)
  end

  def parent_comments_to_load(turbo_comments = nil)
    reject_comments = parent_comments.first
    parent_comments
      .includes(image_attachment: [:blob], user: [profile: [:avatar_attachment]])
      .where.not(id: reject_comments)
      .where.not(id: turbo_comments)
  end
end
