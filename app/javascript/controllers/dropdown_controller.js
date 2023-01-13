import { Controller } from "@hotwired/stimulus"

// closes dropdowns for when a user clicks the right button, or outside the window
// used in:
  // shared/nav notifications/_notifications, _button
  // comments/parent, comment, _form

// Connects to data-controller="dropdown"
export default class extends Controller {
  static targets = ['popup', 'button'];

  // connect() {
  //   console.log('connected to dropdown')
  // }
  
  toggle() {
    if (this.buttonTarget.getAttribute('aria-expanded') == 'false') {
      this.open();
    } else {
      this.close(null);
    }
  }

  open() {
    this.buttonTarget.setAttribute('aria-expanded', 'true');
    this.popupTarget.classList.remove('hidden');

    if (this.popupTarget.id.includes('new_comment')) {
      this.popupTarget.classList.add('pl-5');
    }
  }

  close(event) {
    if (event && (this.popupTarget.contains(event.target) || this.buttonTarget.contains(event.target))) {
      return;
    }

    this.buttonTarget.setAttribute('aria-expanded', 'false');
    this.popupTarget.classList.add('hidden');

    if (this.popupTarget.id.includes('new_comment')) {
      this.popupTarget.classList.remove('pl-5');
    }
  }

}