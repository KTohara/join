import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="dropdown"
export default class extends Controller {
  static targets = ['popup', 'button'];

  // connect() {
  //   console.log('connected to dropdown')
  // }

  close(event) {
    let popup = this.popupTarget;
    let button = this.buttonTarget;
    let popup_is_hidden = popup.classList.contains('hidden');

    if (popup_is_hidden || popup.contains(event.target)) return;
    if (button.contains(event.target)) event.preventDefault();
      
    popup.classList.add('hidden')
  }
}