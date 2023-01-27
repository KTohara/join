import { Controller } from "@hotwired/stimulus"

// closes dropdowns for when a user clicks the right button, or outside the window
// used in:
  // shared/nav notifications/_notifications, _button
  // comments/parent, comment, _form

// Connects to data-controller="dropdown"
export default class extends Controller {
  static targets = ['popup', 'button', 'input', 'container'];

  // connect() {
  //   console.log('connected to dropdown')
  // }
  
  toggle(event) {
    if (this.popupTarget.classList.contains('hidden')) return this.open();
    if (this.buttonTarget.id == 'notification_btn') return this.closeNotifications(event);

    this.close(null);
  }

  open() {
    this.popupTarget.classList.remove('hidden');
    if (this.buttonTarget.id != 'notification_btn') {
      this.inputTarget.focus();
    }
  }

  close(event) {
    if (event && (this.popupTarget.contains(event.target) || this.buttonTarget.contains(event.target))) {
      return;
    }

    this.popupTarget.classList.add('hidden');
  }

  closeNotifications(event) {
    const notifications = this.popupTarget;
    const notificationBtn = this.buttonTarget;
    const popupHidden = notifications.classList.contains('hidden');

    if (popupHidden || notifications.contains(event.target)) return;
    if (notificationBtn.contains(event.target)) event.preventDefault();

    notifications.classList.add('hidden')
  }
}