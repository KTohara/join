import { Controller } from "@hotwired/stimulus"

// closes dropdowns for when a user clicks the cancel button, or outside the window

// Connects to data-controller="dropdown"
export default class extends Controller {
  static targets = ['popup', 'button', 'input', 'submit'];

  connect() {
    this.close = this.close.bind(this);
    this.clickCancel = this.clickCancel.bind(this);
    
    if (this.buttonTarget.id == 'turbo_btn') window.addEventListener('mouseup', this.clickCancel);
  }
  
  toggle() {
    window.addEventListener('mouseup', this.close);
    if (this.popupTarget.classList.contains('hidden')) return this.open();
    
    this.close();
  }

  open() {
    this.popupTarget.classList.remove('hidden');
    this.inputTarget.focus();
  }

  close(event) {
    if (event && (this.popupTarget.contains(event.target) || this.buttonTarget.contains(event.target))) {
      return
    }
    window.removeEventListener('mouseup', this.close);
    this.popupTarget.classList.add('hidden');
  }

  clickCancel(event) {
    if (event && this.popupTarget.contains(event.target)) {
      return this.isButtonClicked(event)
    }
    this.closeViaClick();
  }

  closeViaClick() {
    window.removeEventListener('mouseup', this.clickCancel);
    this.buttonTarget.click();
  }

  isButtonClicked(event) {
    if (this.submitTarget.contains(event.target) || this.buttonTarget.contains(event.target)) {
      window.removeEventListener('mouseup', this.clickCancel);
    }
  }

  burgerToggle() {
    if (this.popupTarget.getAttribute('aria-expanded') === 'false') {
      return this.burgerOpen();
    }
    
    this.burgerClose();
  }

  burgerOpen() {
    this.burgerClose = this.burgerClose.bind(this);
    const menu = this.popupTarget

    menu.classList.toggle('hidden')
    menu.classList.add('animate-slide-in-down')
    menu.addEventListener('animationend', () => {
      menu.classList.remove('animate-slide-in-down', 'hidden')
      window.addEventListener('mouseup', this.burgerClose);
      menu.setAttribute('aria-expanded', 'true')
    });
  }

  burgerClose(event) {
    const menu = this.popupTarget
    if (event && menu.contains(event.target)) {
      return
    }

    menu.classList.add('animate-slide-out-right')
    menu.addEventListener('animationend', () => {
      menu.classList.remove('animate-slide-out-right')
      menu.classList.add('hidden')
      window.removeEventListener('mouseup', this.burgerClose);
      menu.setAttribute('aria-expanded', 'false')
    });
  }
}