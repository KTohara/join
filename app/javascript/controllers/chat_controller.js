import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="chat"
export default class extends Controller {
  static targets = ['popup']

  connect() {
    const messages = document.getElementById('messages')
    messages.addEventListener("DOMNodeInserted", this.resetScroll);
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

  resetScroll() {
    messages.scrollTop = messages.scrollHeight - messages.clientHeight;
  }
}
