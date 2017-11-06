// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

/*
    Put doc here
 */

(function() {
  function suggestRandomCeleb() {
    var celebs = JSON.parse($("#celebrities-data-div")[0].dataset.celebrities);
    var randCeleb = celebs[Math.floor(Math.random() * celebs.length)];
    $('.celeb-display').html(
      "<a href='" + randCeleb.wikilink + "' target='_blank'>" + randCeleb.name + "</a>"
    );
  }

  $(document).ready(function() {
    $(document).on('click', '#suggest-celeb-button', function(e) {
      suggestRandomCeleb();
    });
  });

})();
