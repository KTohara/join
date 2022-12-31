module CommentsHelper
  # renames id to its proper dom_id type (comment, parent_comment etc)
  def dom_id_for_comment(*comment_type, prefix: nil)
    comment_type.map do |type|
      dom_id(type, prefix)
    end.join('_')
  end
end
