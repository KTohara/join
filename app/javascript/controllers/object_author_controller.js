import { Controller } from "@hotwired/stimulus"

// currentUserId is a meta tag at the top of layouts/application
// a workaround for accessing current user for turbo stream broadcasts
// shows edit/delete buttons based on if a current user is the same as the post.author or comment.user

// Connects to data-controller="object-author"
export default class extends Controller {
  static targets = ['editButton', 'deleteButton']
  static values = {
    commenterId: String,
    posterId: String
  }

  connect() {
    this.showEditButton();
    this.showDeleteButton();
  }

  get commenterId() {
    return this.commenterIdValue
  }

  get posterId() {
    return this.posterIdValue
  }

  get currentUserId() {
    return document.querySelector("[name='current-user-id']").content
  }

  showEditButton() {
    if (this.currentUserId === this.commenterId) {
      this.editButtonTarget.classList.remove('hidden')
    }
  }

  showDeleteButton() {
    const userIds = [this.commenterId, this.posterId]
    userIds.forEach(id => {
      if (id === this.currentUserId) return this.deleteButtonTarget.classList.remove('hidden')
    });
  }
}
