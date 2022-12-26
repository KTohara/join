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
  include ActionView::RecordIdentifier
  include ActionView::Helpers

  belongs_to :user
  belongs_to :commentable, polymorphic: true
  belongs_to :parent, optional: true, class_name: 'Comment'
  has_many :comments, -> { includes(%i[user commentable comments]).order(created_at: :desc) },
           class_name: 'Comment',
           foreign_key: :parent_id,
           dependent: :destroy

  validates :body, presence: true, length: { maximum: 8_000 }

  after_create_commit do
    broadcast_add_comment
    increment_comment_count
  end

  after_destroy_commit do
    broadcast_delete_comment
    decrement_comment_count
  end

  private

  def increment_comment_count
    parent = commentable
    parent.increment!(:comment_count)
    broadcast_update_comment_count
  end

  def decrement_comment_count
    parent = commentable
    parent.decrement!(:comment_count) unless parent.comment_count.negative?
    broadcast_update_comment_count
  end

  def broadcast_add_comment
    broadcast_append_later_to(:parent_comments, target: "#{dom_id(commentable)}_comments")
  end

  def broadcast_delete_comment
    broadcast_remove_to(self)
  end

  def broadcast_update_comment_count
    broadcast_update_later_to(
      :comment_count,
      target: dom_id(commentable, :comment_count),
      content: pluralize(commentable.comment_count, 'Comment')
    )
  end
end
