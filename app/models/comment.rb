# == Schema Information
#
# Table name: comments
#
#  id         :bigint           not null, primary key
#  body       :text             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  parent_id  :bigint
#  post_id    :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_comments_on_parent_id  (parent_id)
#  index_comments_on_post_id    (post_id)
#  index_comments_on_user_id    (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (parent_id => comments.id)
#  fk_rails_...  (post_id => posts.id)
#  fk_rails_...  (user_id => users.id)
#
class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  belongs_to :parent, class_name: 'Comment', optional: true

  has_many :comments, foreign_key: :parent_id, dependent: :destroy

  validates :body, presence: true, length: { maximum: 8_000 }
end
