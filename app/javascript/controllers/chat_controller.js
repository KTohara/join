import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="chat"
export default class extends Controller {
  static targets = ['popup', 'scrollWindow']

  connect() {
    debugger
    this.scrollWindowTarget.scrollIntoView()
  }

  closeChat() {
    this.popupTarget.classList.remove('animate-slide-in-up')
    this.popupTarget.classList.add('animate-slide-out-right')
  }
}
