import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="toggleable-panel"
export default class extends Controller {
  static targets = [ 'panel' ];
  static values = { toggleIdentifier: String };

  connect() {
    this.hidden = true;
    this.updatePanelVisibility();
  }

  handle(event) {
    this.hidden = !event.detail.selected;
    this.updatePanelVisibility();
  }

  updatePanelVisibility() {
    if (this.hidden) {
      this.panelTarget.classList.add('hidden');
    } else {
      this.panelTarget.classList.remove('hidden');
    }
  }
}
