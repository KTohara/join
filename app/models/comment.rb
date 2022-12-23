# == Schema Information
#
# Table name: comments
#
#  id               :bigint           not null, primary key
#  body             :text             not null
#  commentable_type :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  commentable_id   :bigint
#  parent_id        :bigint
#  user_id          :bigint           not null
#
# Indexes
#
#  index_comments_on_commentable_type_and_commentable_id  (commentable_type,commentable_id)
#  index_comments_on_parent_id                            (parent_id)
#  index_comments_on_user_id                              (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :commentable, polymorphic: true
  belongs_to :parent, optional: true, class_name: 'Comment'
  has_many :comments, class_name: 'Comment', foreign_key: :parent_id, dependent: :destroy

  validates :body, presence: true, length: { maximum: 8_000 }

  after_create :increment_count
  after_destroy :decrement_count

  def increment_count
    parent = commentable
    parent.increment!(:comment_count)
  end

  def decrement_count
    parent = commentable
    parent.decrement!(:comment_count) unless parent.comment_count.negative?
  end
end
