module ChatsHelper
  def chat_preview_last_message(chat_preview)
    return "No messages yet!" if chat_preview.messages.empty?

    opening_text = 'You: ' if chat_preview.messages.last.user == current_user
    "#{opening_text}#{chat_preview.messages.last.body}"
  end
end
