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


// // Note: see https://stackoverflow.com/questions/39472936/how-should-i-handle-event-listeners-on-page-elements-when-using-turbolinks-5-in
// $(document).on('turbolinks:load', function() {
//   // alert("custom.js document ready");
//   console.log("*****Trying to attach handlers to the card filters buttons");
//   $( "#card-list-filters button" ).click(function() {
//     toggleButtonState(this);
//     applyFilters();
//   });
//   console.log("*****JUST TRIED to attach handlers to the card filters buttons");
// });

$(document).on('click', '#card-list-filters button', function(e) {
  toggleButtonState(this);
  applyFilters();
});
