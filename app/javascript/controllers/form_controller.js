import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="form"
export default class extends Controller {
  static targets = ["input", "button"];

  connect() {
    this.inputTarget.style.resize = 'none';
    this.inputTarget.style.minHeight = `${this.inputTarget.scrollHeight}px`;
    this.inputTarget.style.overflow = 'hidden';
    if (this.inputTarget.value.length == 0) this.buttonTarget.disabled = true;
  }

  resize(event) {
    event.target.style.height = '5px';
    event.target.style.height =  `${event.target.scrollHeight}px`;
  }

  is_empty() {
    let disableStatus = true;
    if (this.inputTarget.value.length == 0) disableStatus = false;
    this.buttonTarget.disabled = !disableStatus
  }
}
