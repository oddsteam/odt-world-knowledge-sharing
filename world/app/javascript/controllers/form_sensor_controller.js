import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="form-sensor"
export default class extends Controller {
  connect() {
  }

  submit(event) {
    event.preventDefault();
    const targets = this.element.querySelectorAll("[data-form-sensor-target]");
    targets.forEach((target) => {
      const eventDataKey = target.getAttribute("data-form-sensor-target");
      if (event.detail.hasOwnProperty(eventDataKey)) {
        const eventData = event.detail[eventDataKey];
        target.value = eventData;
      }
    });
    this.element.requestSubmit();
  }
}
