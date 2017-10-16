/*
    Documentation
 */

(function() {
  function resizeCardFont() {
    $('.qcard').css('font-size', ($('.qcard').width()/26).toString()+'px');
  }

  /**
   * NOTE: Relies on page body tag having data attributes
   * data-controller and data-action, which store the name
   * of the controller and action that served the page, respectively
   * @param  {Array}  allowedControllers array of strings representing allowed controller names
   * @param  {Array}  allowedActions     array of strings representing allowed action names
   * @return {Boolean}                   boolean representing whether current page was served by
   *                                     controller/action found in allowed set of values
   */
  function jsAllowedOnThisPage(allowedControllers, allowedActions) {
    var currentController = $('body').data('controller');
    var currentAction = $('body').data('action');
    function arrayIncludesElement(arr, el) { return (!(arr.indexOf(el) === -1)); }
    return (( arrayIncludesElement(allowedControllers, currentController) && arrayIncludesElement(allowedActions, currentAction) ));
  }

  $(document).on('turbolinks:load', function() {
    var allowedControllers = ["cards"];
    var allowedActions = ["show"];
    if (!(jsAllowedOnThisPage(allowedControllers, allowedActions))) {
      return;
    }

    // resize font
    resizeCardFont()
  });

  $(document).ready(function() {
    $(window).resize(function() {
      // window.currentController and window.currentAction are set in init.js
      if (window.currentController === "cards" && window.currentAction === "show") {
        resizeCardFont();
      } else {
        console.log("NOPPPEEEE");
      }
    });
  });

})();
