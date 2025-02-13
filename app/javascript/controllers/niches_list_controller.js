// app/javascript/controllers/niches_list_controller.js
import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="niches-list"
export default class extends Controller {
  static targets = ["nich"]
  highlight(event) {
    this.nichTargets.forEach((nich) => {
      nich.classList.remove("active")
    });
    event.currentTarget.classList.add("active");
  }
}
