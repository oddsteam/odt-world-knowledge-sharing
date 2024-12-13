import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="tabs-list"
export default class extends Controller {
  static targets = [ "tab" ];
  static values = { defaultTabIdentifier: String, identifiers: Array, classes: Object };

  connect() {
    const selectedTabId = this.defaultTabIdentifierValue;
    this.activeClasses = [];
    this.inactiveClasses = [];
    if (this.classesValue.active) {
      this.activeClasses = this.classesValue.active.split(' ');
    }
    if (this.classesValue.inactive) {
      this.inactiveClasses = this.classesValue.inactive.split(' ');
    }

    setTimeout(
      () => {
        this.activateTab(selectedTabId);
      }, 0);
  }

  toggle(event) {
    this.activateTab(event.params.tabId);
  }

  activateTab(selectedTabId) {
    this.tabTargets.forEach((element, index) => {
      const tabId = element.getAttribute("data-tabs-list-tab-id-param");
      if (this.identifiersValue.indexOf(tabId) >= 0) {
        if (tabId === selectedTabId) {
          this.dispatch('toggled', { detail: { selected: true }, prefix: tabId });
          if (this.inactiveClasses.length > 0) {
            element.classList.remove(...this.inactiveClasses);
          }
          if (this.activeClasses.length > 0) {
            element.classList.add(...this.activeClasses);
          }
        } else {
          this.dispatch('toggled', { detail: { selected: false }, prefix: tabId });
          if (this.activeClasses.length > 0) {
            element.classList.remove(...this.activeClasses);
          }
          if (this.inactiveClasses.length > 0) {
            element.classList.add(...this.inactiveClasses);
          }
        }  
      }
    });
  }
}
