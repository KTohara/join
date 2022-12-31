import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="comment-reply"
export default class extends Controller {
  static targets = ["form"]

  // connect() {
  //   console.log('connected to reply')
  // }

  toggle(event) {
    event.preventDefault()
    this.formTarget.classList.toggle('hidden')
  }
}
