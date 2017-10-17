/*
    Documentation
 */

(function() {
  function resizeCardFont() {
    $('.qcard').css('font-size', ($('.qcard').width()/26).toString()+'px');
  }

  $(document).on('turbolinks:load', function() {
    var allowedControllers = ["cards"];
    var allowedActions = ["show"];
    if (!(jsAllowedOnThisPage(allowedControllers, allowedActions))) {
      return;
    }

    // resize font
    resizeCardFont();
  });

  $(document).ready(function() {
    $(window).resize(function() {
      // window.currentController and window.currentAction are set in init.js
      if (window.currentController === "cards" && window.currentAction === "show") {
        resizeCardFont();
      }
    });
  });

})();
