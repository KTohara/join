module GifsHelper
  def gif_preview_url(object)
    object.gif_url.present? ? object.gif_url : ''
  end

  def gif_preview_class(object)
    'hidden' if object.gif_url.blank?
  end
end
