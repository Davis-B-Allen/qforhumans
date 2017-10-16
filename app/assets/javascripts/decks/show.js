/*
    Script to enable filter buttons for
    suit types in list view of all cards in deck
    Runs when served by decks#show or decks#featured
    with the app/views/decks/show.html.erb template
 */

(function() {
  function toggleButtonState(button) {
    if($(button).hasClass("btn-default")) {
      $(button).removeClass("btn-default");
      $(button).addClass("btn-primary");
    } else {
      $(button).removeClass("btn-primary");
      $(button).addClass("btn-default");
    }
  }

  function applyFilters() {
    var cardFilterButtons, cardFilterButton, i, activeSuits;
    cardFilterButtons = $("#card-list-filters button");
    activeSuits = [];
    for (i = 0; i < cardFilterButtons.length; i++) {
      cardFilterButton = cardFilterButtons[i];
      if ($(cardFilterButton).hasClass("btn-primary")) {
        activeSuits.push(cardFilterButton.dataset.suit);
      }
    }
    $("#card-list a").addClass("hidden");
    if (activeSuits.length == 0) {
      $("#card-list a").removeClass("hidden");
    } else {
      var suitClassList = activeSuits.map(function(suit) {return "." + suit}).join(", ");
      $("#card-list a").filter(suitClassList).removeClass("hidden");
    }
  }

  /**
   * NOTE: Relies on page body tag having data attributes
   * data-controller and data-action, which store the name
   * of the controller and action that served the page, respectively
   * @param  {Array}  allowedControllers array of strings representing allowed controller names
   * @param  {Array}  allowedActions     array of strings representing allowed action names
   * @return {Boolean}                    boolean representing whether current page was served by
   *                                      controller/action found in allowed set of values
   */
  function jsAllowedOnThisPage(allowedControllers, allowedActions) {
    var currentController = $('body').data('controller');
    var currentAction = $('body').data('action');
    function arrayIncludesElement(arr, el) { return (!(arr.indexOf(el) === -1)); }
    return (( arrayIncludesElement(allowedControllers, currentController) && arrayIncludesElement(allowedActions, currentAction) ));
  }

  // $(document).on('turbolinks:load', function() {
  //   var allowedControllers = ["decks"];
  //   var allowedActions = ["show", "featured"];
  //   if (!(jsAllowedOnThisPage(allowedControllers, allowedActions))) {
  //     return;
  //   }
  //
  //   // put page specific javascript here
  // });

  $(document).ready(function() {
    $(document).on('click', '#card-list-filters button', function(e) {
      toggleButtonState(this);
      applyFilters();
    });
  });

})();
