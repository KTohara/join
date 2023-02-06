module CommentsHelper
  # renames id to its proper dom_id type (comment, parent_comment etc)
  def dom_id_for_comment(*comment_type, prefix: nil)
    comment_type.map do |type|
      dom_id(type, prefix)
    end.join('_')
  end

  def comment_flash_message
    if params[:controller] == 'comments/comments'
      'Reply successful!'
    else # params[:controller] == 'comments'
      'Comment successful!'
    end
  end

  def nesting_padding(nesting)
    return if nesting == 1
    'sm:pl-10 pl-6'
  end

  def load_comments_button_margin(parent)
    'sm:ml-10 ml-6' if parent.present?
  end
end
