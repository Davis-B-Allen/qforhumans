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

  $(document).ready(function() {
    $(document).on('click', '#card-list-filters button', function(e) {
      toggleButtonState(this);
      applyFilters();
    });
  });

})();
