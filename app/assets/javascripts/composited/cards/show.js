/*
    Documentation
 */

/**
 * Takes all elements of class qcard and sets their font size to 1/26th of
 * their width.
 * NOTE: this function defined outside the IIFE so that it will be in global scope,
 * hoisted and available to all scripts
 * @return {none} void
 */
 function resizeCardFont() {
   $('.qcard').css('font-size', ($('.qcard').width()/26).toString()+'px');
 }

(function() {
  $(document).on('turbolinks:load', function() {
    var allowedControllerActions = ["cards#show","games#who_am_i"];
    if (!(currentPageIsAmong(allowedControllerActions))) {
      return;
    }

    // resize font
    resizeCardFont();
  });

  $(document).ready(function() {
    $(window).resize(function() {
      var allowedControllerActions = ["cards#show","games#who_am_i"];
      if (currentPageIsAmong(allowedControllerActions)) {
        resizeCardFont();
      }
    });
  });

})();
