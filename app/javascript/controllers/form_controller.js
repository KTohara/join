import { Controller } from "@hotwired/stimulus"

// auto grow/shrinks the comment/post form as user inputs text
// used in any _form partial

// Connects to data-controller="form"
export default class extends Controller {
  static targets = ['input', 'button', 'image'];

  connect() {
    this.inputTarget.style.resize = 'none';
    this.inputTarget.style.minHeight = `${this.inputTarget.scrollHeight}px`;
    this.inputTarget.style.overflow = 'hidden';

    if (this.inputTarget.value.length == 0) {
      this.buttonTarget.disabled = true;
      this.buttonTarget.classList.add('disabled:opacity-50');
    }
  }

  resize(event) {
    event.target.style.height = '5px';
    event.target.style.height = `${event.target.scrollHeight}px`;
  }

  is_empty() {
    let disableStatus = true;
    // if (this.imageTarget.files.length > 0) {
    //   this.buttonTarget.disabled = !disableStatus;
    //   return this.buttonTarget.classList.remove('disabled:opacity-50');
    // }

    if (this.inputTarget.value.length == 0) {
      disableStatus = false
      this.buttonTarget.classList.add('disabled:opacity-50');
      return this.buttonTarget.disabled = !disableStatus;
    }
    this.buttonTarget.disabled = !disableStatus;
    this.buttonTarget.classList.remove('disabled:opacity-50');
  }

  uploadImage(event) {
    this.imageTarget.click();
  }
}
