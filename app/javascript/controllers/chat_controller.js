import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="chat"
export default class Chat extends Controller {
  static targets = ['popup']

  initialize() {
    Chat.messageContainer = document.getElementById('message-container');
    this.resetScroll(Chat.messageContainer)
  }

  connect() {
    Chat.currentUserId = document.querySelector("[name='current-user-id']").content;
    Chat.messages = document.getElementById('messages');
    Chat.previousTop = Chat.messages.children[1];
    Chat.turboMessages = document.getElementById('turbo_messages')

    this.infiniteScrollObserver(Chat.messages);
    this.addMessageObserver(Chat.turboMessages);

    if (this.popupTarget.getAttribute('keep-chat-open') === 'true') return
    
    this.openChat();
  }

  infiniteScrollObserver(messages) {
    const callback = (mutations) => {
      for (const mutation of mutations) {
        const chatInfiniteScroller = document.getElementById('chat_infinite_scroll');
        const topMessage = messages.children[0];
        if (mutation.removedNodes.length === 0 && topMessage === chatInfiniteScroller) {
          Chat.previousTop.scrollIntoView({behavior: 'auto', block: 'end'});
          Chat.previousTop = messages.children[1];
          return
        }
      }
    }
    const observer = new MutationObserver(callback);
    observer.observe(messages, { childList: true });
  }

  addMessageObserver(messages) {
    const observer = new MutationObserver(this.resetScrollWithScrollPoint);
    observer.observe(messages, { childList: true });
  }

  openChat() {
    this.popupTarget.classList.add('animate-slide-in-up');
  }

  closeChat() {
    this.popupTarget.classList.remove('animate-slide-in-up');
    this.popupTarget.classList.add('animate-slide-out-right');
  }

  resetScrollWithScrollPoint() {
    // will scroll only if user is at near bottom of chat, or if the message belongs to user
    // prevents scrolling if user is checking out somewhere else in the chat
    const lastMessage = Chat.messages.lastElementChild;
    const messageUserId = lastMessage.getAttribute('data-object-author-messenger-id-value');
    
    const bottomOfChat = Chat.messageContainer.scrollHeight - Chat.messageContainer.clientHeight;
    const scrollPoint = bottomOfChat - 200;
    if (Chat.messageContainer.scrollTop > scrollPoint || Chat.currentUserId === messageUserId) {
      Chat.messageContainer.scrollTop = bottomOfChat;
    }
  }

  resetScroll(messageContainer) {
    messageContainer.scrollTop = messageContainer.scrollHeight - messageContainer.clientHeight;
  }
}
