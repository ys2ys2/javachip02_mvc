let slideIndex = 0;
showSlides(slideIndex);

function plusSlides(n) {
  showSlides(slideIndex += n);
}

function showSlides(n) {
  let slides = document.getElementsByClassName("slide");
  if (n >= slides.length) {
    slideIndex = 0;  // Loop back to the first slide
  }
  if (n < 0) {
    slideIndex = slides.length - 1;  // Loop back to the last slide
  }
  for (let i = 0; i < slides.length; i++) {
    slides[i].style.display = "none";  // Hide all slides
  }
  slides[slideIndex].style.display = "block";  // Show the current slide
}
