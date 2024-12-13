import { Controller } from "@hotwired/stimulus"
import _ from "lodash";
import dayjs from "dayjs";

// Connects to data-controller="event-data"
const supportedImports = { 'dayjs': dayjs };

export default class extends Controller {

  static targets = [ 'eventData' ];

  connect() {
  }

  handle(event) {
    const templateFunction = _.template(event.params.dataTemplate);
    const preeval = '<%=' + templateFunction(event.detail) + '%>';
    const rendered =  _.template(preeval, { 'imports': supportedImports })();
    this.eventDataTarget.textContent = rendered;
  }
}
