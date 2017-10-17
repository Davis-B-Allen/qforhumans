/*
    This init.js script gets inserted into the top of the application.js manifest
    after external libraries, but before all the composited custom javascripts in
    the composited folder.

    Place all functions neeeded by multiple other scripts here and anything that
    should be run before the page-specific stuff in .composited
 */

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

$(document).ready(function() {
  window.currentController = $('body').data('controller');
  window.currentAction = $('body').data('action');
});
$(document).on('turbolinks:load', function() {
  window.currentController = $('body').data('controller');
  window.currentAction = $('body').data('action');
});
