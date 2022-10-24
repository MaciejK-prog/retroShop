import { LightningElement } from 'lwc';
import XBOX from '@salesforce/resourceUrl/xbox';
import NINTENDO from '@salesforce/resourceUrl/nintendo';
import PLAYSTATION from '@salesforce/resourceUrl/playstation';


export default class CarouselComponent extends LightningElement {

slideIndex = 1;

xboxUrl = XBOX;
nintendoUrl = NINTENDO;
playstationUrl = PLAYSTATION;

renderedCallback() {
 
    this.plusSlides();


}



// Next/previous controls
plusSlides() {
  this.showSlides(this.slideIndex += 1);
}

minusSlides(){

    this.showSlides(this.slideIndex -= 1);

}

// Thumbnail image controls
currentSlide() {
  this.showSlides(this.slideIndex);
}

 showSlides(n) {
  let i;
  let slides = this.template.querySelectorAll(".mySlides");
  let dots = this.template.querySelectorAll(".dot");
  if (n > slides.length) {this.slideIndex = 1}
  if (n < 1) {this.slideIndex = slides.length}
  for (i = 0; i < slides.length; i++) {
    slides[i].style.display = "none";
  }
  for (i = 0; i < dots.length; i++) {
    dots[i].className = dots[i].className.replace(" active", "");
  }
  slides[this.slideIndex-1].style.display = "block";
  dots[this.slideIndex-1].className += " active";
}
}
