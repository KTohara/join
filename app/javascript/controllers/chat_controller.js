import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="chat"
export default class extends Controller {
  static targets = ['popup', 'scrollWindow']

  connect() {
    const lastMessage = this.scrollWindowTarget.lastElementChild
    lastMessage.scrollIntoView({block: "end"});

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
}
