// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

/*
    Put doc here
 */

(function() {

  function updateCelebs() {
    var celebs = JSON.parse($("#celebrities-data-div")[0].dataset.celebrities);
    shuffle(celebs);
    var randCeleb = celebs[0];
    $('.celeb-display').html(
      "<a href='" + randCeleb.wikilink + "' target='_blank'>Look up on Wikipedia</a>"
    );
    posters = document.getElementsByClassName("ring-slat");
    for (var i = 0; i < posters.length; i++) {
      posters[i].firstChild.textContent = celebs[i].name;
    }
  }

  $(document).on('turbolinks:load', function() {
    var allowedControllers = ["celebrities"];
    var allowedActions = ["random"];
    if (!(jsAllowedOnThisPage(allowedControllers, allowedActions))) {
      return;
    }

    updateCelebs();
  });

  $(document).ready(function() {

    $(document).on('click', '#spin-button', function(e) {
      $('#slots-ring').removeClass("spinning");
      $('#slots-ring').removeClass("spinning");
      $('.ring-slat p').fadeOut(300, function() {
        $('#slots-ring').addClass("spinning");
        updateCelebs();
        $('.ring-slat p').fadeIn(1000);
      });
    });

  });

})();
