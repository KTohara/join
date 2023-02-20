import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="chat"
export default class extends Controller {
  static targets = ['popup', 'scrollWindow']

  connect() {
    this.popupTarget.classList.add('animate-slide-in-up')
  }

  closeChat() {
    this.popupTarget.classList.remove('animate-slide-in-up')
    this.popupTarget.classList.add('animate-slide-out-right')
  }
}
