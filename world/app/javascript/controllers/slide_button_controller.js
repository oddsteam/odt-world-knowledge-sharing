import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="slide-button"
export default class extends Controller {
  static targets = [ 'on', 'off' ];
  static values = { selected: Boolean, identifier: String };

  initialize() {
    this.selected = this.selectedValue || false;
    this.updateButton();
  }

  toggle() {
    this.selected = !this.selected;
    this.updateButton();
  }
  
  updateButton() {
    if (this.selected) {
      this.onTarget.classList.remove('hidden');
      this.offTarget.classList.add('hidden');
    } else {
      this.onTarget.classList.add('hidden');
      this.offTarget.classList.remove('hidden');
    }
    this.dispatch('toggled', { detail: { selected: this.selected }, prefix: this.identifierValue });
  }
}
