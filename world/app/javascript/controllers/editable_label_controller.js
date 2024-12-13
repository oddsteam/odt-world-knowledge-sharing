import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="editable-label"
export default class extends Controller {
  static values = { identifier: String, original: String };
  static targets = [ 'textViewer', 'textEditor', 'textEditorInput' ];

  connect() {
    this.openViewer();
  }

  openViewer() {
    this.textViewerTarget.classList.remove('hidden');
    this.textEditorTarget.classList.remove('inline-flex');
    this.textEditorTarget.classList.add('hidden');
  }

  openEditor() {
    this.textViewerTarget.classList.add('hidden');
    this.textEditorTarget.classList.remove('hidden')
    this.textEditorTarget.classList.add('inline-flex');
    this.textEditorInputTarget.focus();
  }

  submit() {
    this.openViewer();
    this.dispatch('changed', { detail: { original: this.originalValue, new: this.textEditorInputTarget.value }, prefix: this.identifierValue });
  }
}
