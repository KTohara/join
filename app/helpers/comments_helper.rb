module CommentsHelper
  # finds the parent of the comment id, depending on the nesting level
  # if the comment is currently nested at 1, and has a max level of 2,
  # the new comment's parent_id will be set to itself
  # else, the new comment will take on the parent_id
  def find_parent_comment_id(comment, nesting, max_nesting)
    if max_nesting.blank? || nesting < max_nesting
      comment.id
    else
      comment.parent_id
    end
  end
end
