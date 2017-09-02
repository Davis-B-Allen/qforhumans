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
  console.log(activeSuits);
  $("#card-list a").addClass("hidden")
  if (activeSuits.length == 0) {
    $("#card-list a").removeClass("hidden")
  } else {
    var suitClassList = activeSuits.map(function(suit) {return "." + suit}).join(", ");
    $("#card-list a").filter(suitClassList).removeClass("hidden");
  }
}

$(document).on('turbolinks:load', function() {
  $( "#card-list-filters button" ).click(function() {
    toggleButtonState(this);
    applyFilters();
  });
});
