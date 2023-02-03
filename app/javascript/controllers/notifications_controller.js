import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="notifications"
export default class extends Controller {
  static targets = ['popup', 'notifications', 'tabBtn', 'tab']
  static values = { defaultTab: String }

  connect() {
    this.setTabSelect()
    this.setNotificationToggler()
  }

  setNotificationToggler() {    
    this.closeNotifications = this.closeNotifications.bind(this)
    const button = document.getElementById('notification_btn');
    button.setAttribute('aria-expanded', 'true')
    window.addEventListener('click', this.closeNotifications);
  }

  setTabSelect() {
    if (this.tabTarget.id === 'no_notifications') return;

    this.tabTargets.map(tab => tab.hidden = true) // default - hide all tabs
    let selectedBtn = this.tabBtnTargets.find(btn => btn.id === this.defaultTabValue)
    let selectedTab = this.tabTargets.find(tab => tab.id === this.defaultTabValue)
    selectedTab.hidden = false
    selectedBtn.classList.add('selected-notification')
  }

  // toggle() {
  //   if (this.buttonTarget.getAttribute('aria-expanded') === 'false') {
  //     return this.buttonTarget.setAttribute('aria-expanded', 'true');
  //   }
  // }

  select(event) {
    if (this.tabTarget.id === 'no_notifications') return;

    let selectedTab = this.tabTargets.find(element => element.id === event.currentTarget.id)
    // close current tab
    this.tabTargets.map(tab => tab.hidden = true) // hide all tabs
    this.tabBtnTargets.map(btn => btn.classList.remove('selected-notification')) // remove all selected
    selectedTab.hidden = false // show current tab
    event.currentTarget.classList.add('selected-notification')
  }

  closeNotifications(event) {
    const notifications = this.popupTarget;
    const button = document.getElementById('notification_btn');
    
    if (button.contains(event.target) && button.getAttribute('aria-expanded') === 'true') {
      event.preventDefault();
    }
    
    if (event && notifications.contains(event.target)) return
    
    notifications.classList.remove('animate-slideLeft');
    notifications.classList.add('animate-slideOut');
    notifications.addEventListener('animationend', () => {
      notifications.classList.add('hidden');
    });

    button.setAttribute('aria-expanded', 'false')
    window.removeEventListener('click', this.closeNotifications);
  }
}
