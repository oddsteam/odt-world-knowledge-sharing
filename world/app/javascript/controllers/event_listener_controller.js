import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="event-listener"
export default class extends Controller {
  static targets = [ 'console' ];
  static values = { eventName: String };

  connect() {
  }

  triggered(event) {
    this.consoleTarget.innerHTML = `<pre>${this.highlightJSON(event.detail)}</pre>`;
  }

  highlightJSON(json) {
    if (typeof json != "string") {
      json = JSON.stringify(json, null, 2);
    }
    
    json = json
      .replace(/&/g, "&amp;")
      .replace(/</g, "&lt;")
      .replace(/>/g, "&gt;");
    
    const highlighted_json = json.replace(
      /("(\\u[a-zA-Z0-9]{4}|\\[^u]|[^\\"])*"(\s*:)?|\b(true|false|null)\b|-?\d+(?:\.\d*)?(?:[eE][+\-]?\d+)?)/g,
      function(match) {
        var cls = "number";
        if (/^"/.test(match)) {
          if (/:$/.test(match)) {
            cls = "text-green-300";
          } else {
            cls = "text-blue-300";
          }
        } else if (/true|false/.test(match)) {
          cls = "text-fuchsia-300";
        } else if (/null/.test(match)) {
          cls = "text-purple-300";
        }
        return '<span class="' + cls + '">' + match + "</span>";
      }
    );

    return `<span class="text-gray-300">${highlighted_json}</span>`;
  }
}
