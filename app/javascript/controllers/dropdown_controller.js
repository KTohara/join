import { Controller } from "@hotwired/stimulus"

// closes dropdowns for when a user clicks the right button, or outside the window

// Connects to data-controller="dropdown"
export default class extends Controller {
  static targets = ['popup', 'button', 'input', 'submit'];

  connect() {
    this.close = this.close.bind(this);
    this.clickCancel = this.clickCancel.bind(this);

    if (this.buttonTarget.id == 'notification_btn') window.addEventListener('mousedown', this.close);
    if (this.buttonTarget.id == 'turbo_btn') window.addEventListener('mousedown', this.clickCancel);
  }
  
  toggle(event) {
    window.addEventListener('mousedown', this.close);
    
    if (this.buttonTarget.id == 'notification_btn') return this.closeNotifications(event);
    if (this.popupTarget.classList.contains('hidden')) return this.open();
    
    this.close();
  }

  open() {
    this.popupTarget.classList.remove('hidden');
    if (this.buttonTarget.id != 'notification_btn') {
      this.inputTarget.focus();
    }
  }

  close(event) {
    if (event && (this.popupTarget.contains(event.target) || this.buttonTarget.contains(event.target))) {
      return
    }
    window.removeEventListener('mousedown', this.close);
    this.popupTarget.classList.add('hidden');
  }

  closeNotifications(event) {
    const notifications = this.popupTarget;
    const notificationBtn = this.buttonTarget;
    const popupHidden = notifications.classList.contains('hidden');
    
    if (popupHidden || notifications.contains(event.target)) return;
    if (notificationBtn.contains(event.target)) event.preventDefault();
    
    window.removeEventListener('mousedown', this.close)
    notifications.classList.add('hidden')
  }

  clickCancel(event) {
    if (event && this.popupTarget.contains(event.target)) {
      return this.isButtonClicked(event)
    }
    window.removeEventListener('mousedown', this.clickCancel);
    this.buttonTarget.click();
  }

  isButtonClicked(event) {
    if (this.submitTarget.contains(event.target) || this.buttonTarget.contains(event.target)) {
      window.removeEventListener('mousedown', this.clickCancel);
    }
  }
}