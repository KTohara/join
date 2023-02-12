import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="gif"
export default class extends Controller {
  static targets = ['field', 'image', 'preview', 'popup', 'button']

  // connect() {
  // }

  setGifToggler() {
    // debugger
    // this.closeGifs = this.closeGifs.bind(this);
    // const button = document.getElementById('gif_button');
    // button.setAttribute('aria-expanded', 'true');
    // window.addEventListener('click', this.closeGifs);
  }

  insertGif(event) {
    if (this.imageTargets.includes(event.target)) {
      const url = event.target.src

      this.fieldTarget.value = url
      this.previewTarget.src = url
      this.previewTarget.classList.remove('hidden')
      this.closeGifs();
    }
  }

  closeGifs(event) {
    // debugger
    // const gifs = this.popupTarget;
    // const button = document.getElementById('gif_button');

    // if (button.contains(event.target) && button.getAttribute('aria-expanded') === 'true') {
    //   event.preventDefault();
    // }

    // if (event && gifs.contains(event.target)) return;

    // gifs.classList.remove('animate-slideDown');
    gifs.classList.add('hidden');

    // button.setAttribute('aria-expanded', 'false');
    // window.removeEventListener('click', this.closeGifs);
  }
}
