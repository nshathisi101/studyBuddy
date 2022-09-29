import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="turbomodal"
export default class extends Controller {
  connect() {
  }
  submitEnd(e){
    if (e.detail.success){
      document.getElementById('theModalDark').classList.remove('myClass');
      document.getElementById('theModal').classList.remove('myClass');
    
      document.getElementById('theModalDark').classList.add('myClass2');
      document.getElementById('theModal').classList.add('myClass2');
    }
  }
  hideModal(){
    this.element.remove()
  }
}
