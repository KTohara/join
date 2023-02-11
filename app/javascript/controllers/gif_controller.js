import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="gif"
export default class extends Controller {
  static targets = ['field', 'image', 'preview', 'gifMenu']
  connect() {
  }

  insertGif(event) {
    if (this.imageTargets.includes(event.target)) {
      const url = event.target.src

      this.fieldTarget.value = url
      this.previewTarget.src = url
      this.previewTarget.classList.remove('hidden')
      this.close();
    }
  }

  close() {
    this.gifMenuTarget.classList.add('hidden')
  }
}
