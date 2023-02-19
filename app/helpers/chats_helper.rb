module ChatsHelper
  def chat_preview_last_message(chat_preview)
    last_message = chat_preview.messages.last
    opening_text = 'You:' if last_message.user == current_user

    if last_message.body.empty? && (last_message.image.present? || last_message.gif_url.present?)
      "#{opening_text} Picture"
    else
      "#{opening_text} #{last_message.body}"
    end
  end
end
