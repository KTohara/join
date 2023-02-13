import { Controller } from "@hotwired/stimulus"

const button = document.getElementById('gif_button');

// Connects to data-controller="gif"
export default class extends Controller {
  static targets = ['field', 'image', 'preview', 'popup', 'removeGif']

  // connect() {
  // }

  setGifToggler(event) {
    if (button.contains(event.target) && button.getAttribute('aria-expanded') === 'true') {
      event.preventDefault();
      button.setAttribute('aria-expanded', 'false');
      return window.removeEventListener('mouseup', this.checkOpen); 
    }

    this.checkOpen = this.checkOpen.bind(this);
    button.setAttribute('aria-expanded', 'true');
    window.addEventListener('mouseup', this.checkOpen);
  }

  insertGif(event) {
    if (this.imageTargets.includes(event.target)) {
      const url = event.target.src

      this.fieldTarget.value = url
      this.previewTarget.src = url
      this.previewTarget.classList.remove('hidden')
      this.removeGifTarget.classList.remove('hidden')

      this.closeGifs();
    }
  }

  checkOpen(event) {
    const gifs = this.popupTarget;

    if (button.contains(event.target) && button.getAttribute('aria-expanded') === 'true') {
      event.preventDefault();
    } else {
      button.setAttribute('aria-expanded', 'false');
    }

    if (gifs.contains(event.target)) return;

    this.closeGifs();
  }

  closeGifs() {
    const gifs = this.popupTarget;

    gifs.classList.remove('animate-slide-in-up');
    gifs.classList.add('animate-slide-out-left');
    window.removeEventListener('mouseup', this.closeGifs); 
  }

  remove() {
    this.fieldTarget.value = ''
    this.previewTarget.src = ''
    this.previewTarget.classList.add('hidden')
    this.removeGifTarget.classList.add('hidden')
  }
}
