import { Controller } from "@hotwired/stimulus"

// currentUserId is a meta tag at the top of layouts/application
// a workaround for accessing current user for turbo stream broadcasts
// shows edit/delete buttons based on if a current user is the same as the post.author or comment.user

const currentUserId = document.querySelector("[name='current-user-id']").content;

// Connects to data-controller="object-author"
export default class extends Controller {
  static targets = ['editButton', 'deleteButton', 'comment', 'message']
  static values = {
    commenterId: String,
    posterId: String,
    userMessageId: String
  }

  commentTargetConnected() {
    this.showEditButton();
    this.showDeleteButton();
  }

  showEditButton() {
    if (currentUserId === this.commenterIdValue) {
      this.editButtonTarget.classList.remove('hidden')
    }
  }

  showDeleteButton() {
    const userIds = [this.commenterIdValue, this.posterIdValue];
    userIds.forEach(id => {
      if (id === currentUserId) return this.deleteButtonTarget.classList.remove('hidden');
    });
  }

  messageTargetConnected() {
    if (currentUserId === this.userMessageIdValue) {
      this.messageTarget.classList.add('current-user-message')
    }
  }
}
