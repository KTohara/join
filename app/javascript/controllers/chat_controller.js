import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="chat"
export default class extends Controller {
  static targets = ['popup']

  connect() {
    const messages = document.getElementById('messages')
    const observer = new MutationObserver(this.resetScrollWithScrollPoint);
    observer.observe(messages, { 
      childList: true,
      subtree: true,
      attributes: false,
      characterData: false
    });
    
    this.resetScroll(messages);
    if (this.popupTarget.getAttribute('aria-open') === 'true') return
    
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
    const currentUserId = document.querySelector("[name='current-user-id']").content;
    // previousElementSibling used due to broadcasted turbo_frame_tag for auto checking message notifications
    const messengerId = messages.lastElementChild.getAttribute('data-object-author-messenger-id-value')
    const bottomOfChat = messages.scrollHeight - messages.clientHeight;
    const scrollPoint = bottomOfChat - 100;
    // will scroll only if we're at the scroll point in the chat window
    if (messages.scrollTop > scrollPoint || currentUserId === messengerId) {
      messages.scrollTop = bottomOfChat + 9999;
    }
  }

  resetScroll(messages) {
    messages.scrollTop = messages.scrollHeight - messages.clientHeight + 9999;
  }
}
