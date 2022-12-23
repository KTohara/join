# == Schema Information
#
# Table name: posts
#
#  id            :bigint           not null, primary key
#  body          :text             not null
#  comment_count :integer          default(0)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  user_id       :bigint           not null
#
# Indexes
#
#  index_posts_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Post < ApplicationRecord
  belongs_to :user

  has_many :comments, -> { Post.parent_comments },
           as: :commentable,
           dependent: :destroy

  validates :body, presence: true, length: { maximum: 15_000 }

  scope :parent_comments, -> { Comment.includes([:user, :comments]).where(parent: nil) }

  def formatted_date
    created_at.strftime('%B %e')
  end
end
