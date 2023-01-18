# == Schema Information
#
# Table name: comments
#
#  id               :bigint           not null, primary key
#  body             :text             not null
#  commentable_type :string
#  like_count       :integer          default(0)
#  nesting          :integer          default(1)
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
  include ActionView::Helpers::TextHelper

  MAX_NESTING_LEVEL = 2

  belongs_to :user
  belongs_to :commentable, polymorphic: true, counter_cache: :comment_count
  belongs_to :parent, optional: true, class_name: 'Comment'

  has_one_attached :image
  has_many :comments, -> { order(created_at: :asc) },
           class_name: 'Comment',
           foreign_key: :parent_id,
           dependent: :destroy

  has_many :likes, as: :likeable, dependent: :destroy
  has_many :notifications, as: :notifiable, dependent: :destroy

  validates :body, presence: true, length: { maximum: 8_000 }
  validates :nesting, presence: true

  after_create_commit do
    broadcast_create_to_comment
    broadcast_update_to_comment_count
  end

  after_destroy_commit do
    broadcast_remove_to(self)
    broadcast_update_to_comment_count
  end

  def set_nesting(parent_comment)
    return nesting if parent_comment.nil?

    self.parent = if Comment.max_nesting > parent_comment.nesting
      parent_comment
    else
      parent_comment.parent
    end
    parent.nesting + 1
  end

  private

  def self.max_nesting
    MAX_NESTING_LEVEL
  end

  def broadcast_create_to_comment
    broadcast_append_later_to [commentable, :comments],
      target: dom_id(parent || commentable, :comments),
      partial: 'comments/parent_comment',
      locals: { user: (parent || commentable).user }
  end

  def broadcast_update_to_comment_count
    broadcast_replace_to [commentable, :comment_count],
      target: dom_id(commentable, :comment_count),
      partial: 'posts/comment_counter',
      locals: { post: commentable }
  end
end
