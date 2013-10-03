function animateLinks() {
  $('.link').fadeTo(1000, 1);
}

function animateTags() {
  $('.tag').fadeTo(1000, 1);
}

$(document).ready(function() {
  animateLinks();
  animateTags();
});