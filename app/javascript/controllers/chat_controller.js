import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="chat"
export default class extends Controller {
  static targets = ['popup']

  connect() {
    const messages = document.getElementById('messages')
    messages.addEventListener("DOMNodeInserted", this.resetScrollWithScrollPoint);
    this.resetScroll(messages);
    if (this.popupTarget.getAttribute('aria-open') === 'true') return
    
    this.popupTarget.classList.add('animate-slide-in-up');
  }

  disconnect() {
    messages.removeEventListener("DOMNodeInserted", this.resetScroll);
  }

  openChat() {
    this.popupTarget.classList.add('animate-slide-in-up');
  }

  closeChat() {
    this.popupTarget.classList.remove('animate-slide-in-up');
    this.popupTarget.classList.add('animate-slide-out-right');
  }

  resetScrollWithScrollPoint() {
    const bottomOfChat = messages.scrollHeight - messages.clientHeight;
    const scrollPoint = bottomOfChat - 500;
    // will scroll only if we're at the scroll point in the chat window
    if (messages.scrollTop > scrollPoint) {
      this.resetScroll(messages);
    }
  }

  resetScroll() {
    messages.scrollTop = messages.scrollHeight - messages.clientHeight;
  }
}
