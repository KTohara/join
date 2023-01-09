import { Controller } from "@hotwired/stimulus"

// toggles "hidden" tailwind class when a user clicks on 'Reply'
// used in comments/_comment

// Connects to data-controller="comment-reply"
export default class extends Controller {
  static targets = ["form", "reply", "example"]

  // connect() {
  //   console.log('connected to reply')
  // }

  toggle(event) {
    event.preventDefault()
    // debugger

    // let newCommentId = `${this.replyTarget.id}_new_comment`

    // this.formTarget.setAttribute('id', newCommentId)
    this.formTarget.classList.toggle('hidden')
  }

  show(event) {
    let newCommentId = `${this.replyTarget.id}_new_comment`
    this.exampleTarget.setAttribute('id', newCommentId)
  }
}
// parent div needs id of "dom_id(comment, :comment) - comments_comment_###"
// form needs id comment_###_new_comment
// form action /comments/###/comments