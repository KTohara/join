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
    else # 'comments'
      'Comment successful!'
    end
  end

  def nesting_padding(nesting)
    return if nesting == 1
    'pl-8'
  end

  def load_comments_button_margin(parent)
    if parent.present?
      'ml-8'
    end
  end

  def reject_new_turbo_comments(params)
    debugger
    if params[:reject_comments].present?
      params[:reject_comments].each_value do
        render 'comments/comments_to_reject', comment: comment
      end
    end
  end
end
