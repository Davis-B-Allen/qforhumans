// Script for a simple game to sort deck down to identify the worst card
// Runs when served by decks#sorting_game
// with the app/views/decks/sorting_game.html.erb template
(function() {
  // var goodPile = [];
  // var discardPile = [];
  // var stupidPile = [];
  // var roundCards = [];
  // var reservePile;
  // var cardInitialData;
  var gameChoicePhase = "best";
  var roundHandSize;

  /**
   * Shuffles array in place.
   * @param {Array} a items The array containing the items.
   */
  function shuffle(a) {
      var j, x, i;
      for (i = a.length; i; i--) {
          j = Math.floor(Math.random() * i);
          x = a[i - 1];
          a[i - 1] = a[j];
          a[j] = x;
      }
  }

  /**
   * draws x cards off a pile of cards (array of card objects) and returns them
   * if fewer than x cards remain in pile, draw and return only the cards that remain
   * @param {Array} pile array of card objects
   * @param {Number} x number of cards to draw from pile
   * @return {Array} returns an array of cards drawn from pile
   */
  function drawXCards(pile, x) {
    var draw = [];
    for (var i = 0; i < x; i++) {
      var card = pile.pop();
      if (card) {
        draw.push(card);
      }
    }
    return draw;
  }

  function deleteCurrentCardChoices() {
    var cardChoices = document.getElementById('card-choices');
    while (cardChoices.firstChild) {
      cardChoices.removeChild(cardChoices.firstChild);
    }
  }

  function drawSeveralSubmitRound() {
    console.log("submitting round!");
    $('.decks-sortinggame #card-choices .sg-qcard').each(function(i,card) {
      if ($(card).hasClass('good-card')) {
        transferCard(roundCards, goodPile, parseInt(card.dataset.cardid))
      } else if ($(card).hasClass('neutral-card')) {
        transferCard(roundCards, discardPile, parseInt(card.dataset.cardid))
      } else if ($(card).hasClass('stupid-card')) {
        transferCard(roundCards, stupidPile, parseInt(card.dataset.cardid))
      }
    });
    if (reservePile.length > 0) {
      playDrawSeveralRound(roundHandSize);
    } else {
      console.log(goodPile);
      console.log(discardPile);
      console.log(stupidPile);
      // add discardPile and stupidPile to reservePile
      reservePile = reservePile.concat(discardPile);
      discardPile = [];
      reservePile = reservePile.concat(stupidPile);
      stupidPile = [];
      /*  maybe grab goodPile data and start building and object that can be logged
          with AJAX call to record history of game? */
      if (roundHandSize > 3) {
        drawSeveralRundown(roundHandSize - 1);
      } else {
        // START THE BINARY RUNDOWNS
        console.log("DONT RUN ANOTHER drawSeveralRundown !!!");
      }
      // finish up the set of rounds (the rundown) and continue to the next rundown
      // call drawThreeRounds
    }
  }

  function multiCardOnCardClick() {
    if ($(this).hasClass('locked')) {
      console.log("Card is locked");
    } else {
      $('.decks-sortinggame #card-choices .sg-qcard').not(".locked").removeClass("good-card neutral-card stupid-card");
      $('.decks-sortinggame #card-choices .sg-qcard').not(".locked").not(this).addClass("neutral-card");
      var cardClass = ((gameChoicePhase == "best") ? "good-card" : "stupid-card");
      $(this).addClass(cardClass);
      $('.decks-sortinggame #next-button').removeClass('disabled');
    }
  }

  function multiCardOnNextClick() {
    if ($(this).hasClass('disabled')) {
      return;
    }
    if (gameChoicePhase == "best") {
      $('.decks-sortinggame #card-choices .sg-qcard.good-card').addClass("locked")
      chooseWorstOfSeveral();
    } else if (gameChoicePhase == "worst") {
      drawSeveralSubmitRound();
    } else {
      console.log("UNEXPECTED VALUE FOR gameChoicePhase");
    }
  }

  function multiCardOnBackClick() {
    console.log("Back");
    if ($(this).hasClass('disabled')) {
      return;
    }
    $('.decks-sortinggame #card-choices .sg-qcard').removeClass("good-card stupid-card locked").addClass("neutral-card");
    chooseBestOfSeveral();
  }

  function configureDrawSeveralButtons() {
    //
    $('.decks-sortinggame #back-button').show();
    $('.decks-sortinggame #next-button').unbind();
    $('.decks-sortinggame #back-button').unbind();
    $('.decks-sortinggame #next-button').on( "click", multiCardOnNextClick);
    $('.decks-sortinggame #back-button').on( "click", multiCardOnBackClick);
  }

  function chooseBestOfSeveral() {
    gameChoicePhase = "best";
    $('.decks-sortinggame #sg-instructions').html('Choose the best card');
    $('.decks-sortinggame #back-button').addClass('disabled');
    $('.decks-sortinggame #next-button').addClass('disabled');
  }

  function chooseWorstOfSeveral() {
    gameChoicePhase = "worst";
    $('.decks-sortinggame #sg-instructions').html('Choose the worstttttttt card');
    $('.decks-sortinggame #back-button').removeClass('disabled');
    $('.decks-sortinggame #next-button').addClass('disabled');
  }

  function transferCard(fromPile, toPile, id) {
    var targetCard = fromPile.find(function(card) {
      return card.id === id;
    });
    var newPile = fromPile.filter(function(card) {
      return card.id != id;
    });
    toPile.push(targetCard);
    fromPile = newPile;
  }

  function addCard(cardDataElement) {
    var cardChoices = document.getElementById('card-choices');
    var iDiv = document.createElement('div');
    var iiDiv = document.createElement('div');
    iDiv.className = 'col-sm-3 ';
    iiDiv.className = 'sg-qcard neutral-card';
    iiDiv.innerHTML = cardDataElement.lens_prefix + " " + cardDataElement.lens_name;
    iiDiv.setAttribute('data-cardid', cardDataElement.id);
    cardChoices.appendChild(iDiv);
    iDiv.appendChild(iiDiv);
  }

  function playDrawSeveralRound(numCardsPerRound) {
    roundCards = drawXCards(reservePile, numCardsPerRound);
    if (roundCards.length > 0) {
      deleteCurrentCardChoices();
      roundCards.forEach(function(card) {
        addCard(card);
      });
      $('.decks-sortinggame #card-choices .sg-qcard').on( "click", multiCardOnCardClick);
      chooseBestOfSeveral();
    } else {
      console.log("NOT ENOUGH CARDS LEFT!!!");
    }
  }

  // NOTE: Never call this with fewer than 3 numCardsPerRound OR WE'LL HAVE PROBLEMS
  function drawSeveralRundown(numCardsPerRound) {
    roundHandSize = numCardsPerRound;
    configureDrawSeveralButtons();
    if (reservePile.length > 0) {
      playDrawSeveralRound(roundHandSize);
    } else {
      console.log("NO CARD DATA!!!");
    }
  }

  function startGame() {
    // remove jokers
    reservePile = reservePile.filter(function(el) {
  	   return (el.face_suit != 5 && el.face_suit != 6);
    });
    reservePile = reservePile.slice(0,12);
    shuffle(reservePile);
    // NOTE: reservePile length MUST BE A MULTIPLE OF 4 OTHERWISE WE'LL HAVE PROBLEMS
    drawSeveralRundown(4);
  }

  $(document).on('turbolinks:load', function() {
    if (!($('body').data('controller') === 'decks' && $('body').data('action') === 'sorting_game')) {
      return;
    }

    cardInitialData = JSON.parse($("#card-data-div")[0].dataset.cards);
    reservePile = JSON.parse($("#card-data-div")[0].dataset.cards);
    window.reservePile = JSON.parse($("#card-data-div")[0].dataset.cards);
    window.cardInitialData = JSON.parse($("#card-data-div")[0].dataset.cards);
    window.goodPile = [];
    window.roundCards = [];
    window.discardPile = [];
    window.stupidPile = [];

    startGame();
  });
})();
