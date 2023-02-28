import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="chat"
export default class extends Controller {
  static targets = ['popup']

  connect() {
    const chatContainer = document.getElementById('message_container')
    const observer = new MutationObserver(this.resetScrollWithScrollPoint);
    observer.observe(chatContainer, { 
      childList: true,
      subtree: true,
      attributes: false,
      characterData: false
    });
    
    this.resetScroll(chatContainer);
    if (this.popupTarget.getAttribute('keep-chat-open') === 'true') return
    
    this.popupTarget.classList.add('animate-slide-in-up');
  }

  openChat() {
    this.popupTarget.classList.add('animate-slide-in-up');
  }

  closeChat() {
    this.popupTarget.classList.remove('animate-slide-in-up');
    this.popupTarget.classList.add('animate-slide-out-right');
  }

  resetScrollWithScrollPoint() {
    // will scroll only if user is at near bottom of chat, or if the message belongs to user
    // prevents scrolling if user is checking out somewhere else in the chat
    const chatContainer = document.getElementById('message_container')
    const currentUserId = document.querySelector("[name='current-user-id']").content;
    const messages = document.getElementById('messages')
    const lastMessage = messages.lastElementChild
    const messageUserId = lastMessage.getAttribute('data-object-author-messenger-id-value')
    
    const bottomOfChat = chatContainer.scrollHeight - chatContainer.clientHeight;
    const scrollPoint = bottomOfChat - 500;

    if (chatContainer.scrollTop > scrollPoint || currentUserId === messageUserId) {
      chatContainer.scrollTop = bottomOfChat;
    }
  }

  resetScroll(chatContainer) {
    chatContainer.scrollTop = chatContainer.scrollHeight - chatContainer.clientHeight;
  }
}
