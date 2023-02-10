import { Controller } from "@hotwired/stimulus"

// auto grow/shrinks the comment/post form as user inputs text
// used in any _form partial

// Connects to data-controller="form"
export default class extends Controller {
  static targets = ['input', 'submit', 'image', 'preview'];

  connect() {
    this.inputTarget.style.resize = 'none';
    this.inputTarget.style.minHeight = `${this.inputTarget.scrollHeight}px`;
    this.inputTarget.style.overflow = 'hidden';

    if (this.inputTarget.value.length == 0 && this.inputTarget.getAttribute('data-form-type') != 'profile') {
      this.submitTarget.disabled = true;
      this.submitTarget.classList.add('disabled:opacity-50');
    }
  }

  resize(event) {
    event.target.style.height = '5px';
    event.target.style.height = `${event.target.scrollHeight}px`;
  }

  isEmpty() {
    let disableStatus = true;

    if (this.imageTarget.files.length > 0) {
      this.submitTarget.disabled = !disableStatus;
      return this.submitTarget.classList.remove('disabled:opacity-50');
    }

    if (this.inputTarget.value.trim().length === 0) {
      disableStatus = false
      this.submitTarget.classList.add('disabled:opacity-50');
      return this.submitTarget.disabled = !disableStatus;
    }
    this.submitTarget.disabled = !disableStatus;
    this.submitTarget.classList.remove('disabled:opacity-50');
  }

  uploadImage() {
    this.imageTarget.click();
  }

  preview() {
    const imageFile = this.imageTarget.files;

    if (imageFile.length >= 1) {
      this.previewTarget.textContent = `Image: ${imageFile[0].name}`;
    } else {
      this.previewTarget.textContent = '';
    }
  }
}
