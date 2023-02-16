import { Controller } from "@hotwired/stimulus"

// const button = document.getElementById('gif_button');

// Connects to data-controller="gif"
export default class extends Controller {
  static targets = ['image', 'popup', 'openGifMenuBtn', 'removeGifBtn', 'gifField', 'preview', ]

  // connect() {
  // }

  setGifToggler(event) {
    if (this.openGifMenuBtnTarget.contains(event.target) && this.openGifMenuBtnTarget.getAttribute('aria-expanded') === 'true') {
      event.preventDefault();
      this.openGifMenuBtnTarget.setAttribute('aria-expanded', 'false');
      return window.removeEventListener('mouseup', this.checkOpen); 
    }

    this.checkOpen = this.checkOpen.bind(this);
    this.openGifMenuBtnTarget.setAttribute('aria-expanded', 'true');
    window.addEventListener('mouseup', this.checkOpen);
  }

  insertGif(event) {
    if (this.imageTargets.includes(event.target)) {
      const url = event.target.src

      this.gifFieldTarget.value = url
      this.previewTarget.src = url
      this.previewTarget.classList.remove('hidden')
      this.removeGifBtnTarget.classList.remove('hidden')

      this.closeGifs();
    }
  }

  checkOpen(event) {
    if (this.openGifMenuBtnTarget.contains(event.target) && this.openGifMenuBtnTarget.getAttribute('aria-expanded') === 'true') {
      event.preventDefault();
    } else {
      this.openGifMenuBtnTarget.setAttribute('aria-expanded', 'false');
    }

    if (this.popupTarget.contains(event.target)) return;

    this.closeGifs();
  }

  closeGifs() {
    this.popupTarget.classList.remove('animate-slide-in-up');
    this.popupTarget.classList.add('animate-slide-out-left');
    this.popupTarget.addEventListener('animationend', () => {
      this.popupTarget.classList.add('hidden');
    });
    window.removeEventListener('mouseup', this.closeGifs); 
  }

  remove() {
    this.gifFieldTarget.value = ''
    this.previewTarget.src = ''
    this.previewTarget.classList.add('hidden')
    this.removeGifBtnTarget.classList.add('hidden')
  }
}
