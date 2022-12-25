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

  # renames id to post_commentable type (comment, comment_nested etc)
  # examples:
  # post_4_comment_10
  # post_3_new_comment
  # post_5_comment_nested_2
  def dom_id_for_comments(*comment_type, prefix: nil)
    comment_type.map do |type|
      dom_id(type, prefix)
    end.join('_')
  end
end
