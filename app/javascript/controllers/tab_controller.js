import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="tab"
export default class extends Controller {
  static targets = ["tab", "content"];

  connect() {
    console.log(this.contentTargets);
  }

  changeTab(evt) {
    evt.preventDefault();

    this.contentTargets.forEach((tab) => {
      tab.classList.add('d-none')
    })

    this.element.querySelector(`#${evt.params.identifier}`).classList.remove('d-none')
  }
}
