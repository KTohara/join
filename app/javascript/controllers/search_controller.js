import { Controller } from "@hotwired/stimulus"

// real time search for users in the users/index view

// Connects to data-controller="search"
export default class extends Controller {
  static targets = ['form'];

  // connect() {
  //   console.log('connected to user search');
  // }

  debounce() {
    clearTimeout(this.timeout)
    this.timeout = setTimeout(() => {
      this.formTarget.requestSubmit()
    }, 300)
  }
}
