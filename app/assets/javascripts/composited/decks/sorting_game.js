/*
    Script for a simple game to sort deck down to identify the worst card
    Runs when served by decks#sorting_game
    with the app/views/decks/sorting_game.html.erb template
 */

(function() {
  var goodPile = [];
  var discardPile = [];
  var stupidPile = [];
  var roundCards = [];
  var reservePile;
  // var cardInitialData;
  var gameChoicePhase = "best";
  var roundHandSize;

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
        drawSeveralRundown(roundHandSize - 1, true);
      } else {
        startBinaryRundowns(roundHandSize - 1);
      }
    }
  }

  function drawTwoSubmitRound() {
    console.log("submitting 2222 round!");
    $('.decks-sortinggame #card-choices .sg-qcard').each(function(i,card) {
      if ($(card).hasClass('stupid-card')) {
        transferCard(roundCards, stupidPile, parseInt(card.dataset.cardid))
      } else if ($(card).hasClass('neutral-card')) {
        transferCard(roundCards, goodPile, parseInt(card.dataset.cardid))
      }
    });
    if (reservePile.length > 0) {
      console.log(reservePile.length + " Cards Left");
      playDrawTwoRound();
    } else {
      console.log("remaining Piles:");
      console.log(goodPile);
      console.log(discardPile);
      console.log(stupidPile);
      // add discardPile and stupidPile to reservePile
      reservePile = reservePile.concat(stupidPile);
      stupidPile = [];
      /*  maybe grab goodPile data and start building and object that can be logged
          with AJAX call to record history of game? */
      if (reservePile.length > 1) {
        drawTwoRundown();
      } else {
        gameOver();
      }
    }
  }

  function gameOver() {
    $('.decks-sortinggame #next-button').hide();
    $('.decks-sortinggame #back-button').hide();
    var gameOverMessage = "The stupidest Card is: " + reservePile[0].lens_prefix + " " + reservePile[0].lens_name;
    $('.decks-sortinggame #sg-instructions').html(gameOverMessage);
    $('.decks-sortinggame #card-choices .sg-qcard').addClass("locked")
    console.log("Game Over");
    console.log("The stupidest Card is: " + reservePile[0].lens_prefix + " " + reservePile[0].lens_name);
  }

  function onCardClick() {
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

  function onNextClick() {
    if ($(this).hasClass('disabled')) {
      return;
    }
    if (gameChoicePhase == "best") {
      $('.decks-sortinggame #card-choices .sg-qcard.good-card').addClass("locked");
      chooseWorstOf(roundHandSize);
      $('body').scrollTop(0);
    } else if (gameChoicePhase == "worst") {
      if (roundHandSize > 2) {
        drawSeveralSubmitRound();
        $('body').scrollTop(0);
      } else {
        drawTwoSubmitRound();
        $('body').scrollTop(0);
      }
      $('body').scrollTop(0);
    } else {
      console.log("UNEXPECTED VALUE FOR gameChoicePhase");
    }
  }

  function onBackClick() {
    if ($(this).hasClass('disabled')) {
      return;
    }
    $('.decks-sortinggame #card-choices .sg-qcard').removeClass("good-card stupid-card locked").addClass("neutral-card");
    chooseBestOfSeveral();
    $('body').scrollTop(0);
  }

  function configureDrawSeveralButtons() {
    $('.decks-sortinggame #back-button').show();
    $('.decks-sortinggame #next-button').unbind();
    $('.decks-sortinggame #back-button').unbind();
    $('.decks-sortinggame #next-button').on( "click", onNextClick);
    $('.decks-sortinggame #back-button').on( "click", onBackClick);
  }

  function configureDrawTwoButtons() {
    $('.decks-sortinggame #back-button').hide();
    $('.decks-sortinggame #next-button').unbind();
    $('.decks-sortinggame #back-button').unbind();
    $('.decks-sortinggame #next-button').on( "click", onNextClick);
  }

  function chooseBestOfSeveral() {
    gameChoicePhase = "best";
    $('.decks-sortinggame #sg-instructions').html('Of the following cards, choose the best:');
    $('.decks-sortinggame #back-button').addClass('disabled');
    $('.decks-sortinggame #next-button').addClass('disabled');
  }

  function chooseWorstOf(ofHowMany) {
    var instructionText;
    if (ofHowMany == 2) {
      instructionText = "---******* Of these two cards, choose the worst:";
      $('.decks-sortinggame #back-button').addClass('disabled');
    } else {
      instructionText = "---******* Of the remaining cards, choose the worst:";
      $('.decks-sortinggame #back-button').removeClass('disabled');
    }
    gameChoicePhase = "worst";
    $('.decks-sortinggame #sg-instructions').html(instructionText);
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
    iiDiv.setAttribute('data-cardid', cardDataElement.id);
    cardChoices.appendChild(iDiv);
    iDiv.appendChild(iiDiv);
    var cardH = document.createElement('h3');
    cardH.innerHTML = cardDataElement.lens_name;
    var cardP1 = document.createElement('p');
    cardP1.innerHTML = "Ask yourself: " + cardDataElement.me_question;
    iiDiv.appendChild(cardH);
    iiDiv.appendChild(cardP1);
  }

  function playDrawSeveralRound(numCardsPerRound) {
    roundCards = drawXCards(reservePile, numCardsPerRound);
    if (roundCards.length > 0) {
      deleteCurrentCardChoices();
      roundCards.forEach(function(card) {
        addCard(card);
      });
      $('.decks-sortinggame #card-choices .sg-qcard').on( "click", onCardClick);
      chooseBestOfSeveral();
    } else {
      console.log("NOT ENOUGH CARDS LEFT!!!");
    }
  }

  function playDrawTwoRound() {
    roundCards = drawXCards(reservePile, 2);
    if (roundCards.length > 0) {
      deleteCurrentCardChoices();
      roundCards.forEach(function(card) {
        addCard(card);
      });
      $('.decks-sortinggame #card-choices .sg-qcard').on( "click", onCardClick);
      chooseWorstOf(roundHandSize);
    } else {
      console.log("NOT ENOUGH CARDS LEFT!!!");
    }
  }

  // NOTE: Never call this with fewer than 3 numCardsPerRound OR WE'LL HAVE PROBLEMS
  function drawSeveralRundown(numCardsPerRound, shouldShuffle) {
    if (shouldShuffle) {
      shuffle(reservePile);
    }
    roundHandSize = numCardsPerRound;
    configureDrawSeveralButtons();
    if (reservePile.length > 0) {
      playDrawSeveralRound(roundHandSize);
    } else {
      console.log("NO CARD DATA!!!");
    }
  }

  function drawTwoRundown() {
    shuffle(reservePile);
    configureDrawTwoButtons();
    // if reservePile not a multiple of 2, add one goodPile to it
    console.log("reservePile length is " + reservePile.length);
    if (reservePile.length > 0) {
      if ((reservePile.length % 2) != 0) {
        shuffle(goodPile);
        transferCard(goodPile, reservePile, goodPile[0].id);
      }
      console.log("reservePile length is " + reservePile.length);
      playDrawTwoRound();
    } else {
      console.log("NO CARD DATA!!!");
    }
  }

  function startBinaryRundowns(numCardsPerRound) {
    // this numCardsPerRound should be 2 now.
    roundHandSize = numCardsPerRound;
    drawTwoRundown();
  }

  function startGame() {
    // remove jokers
    reservePile = reservePile.filter(function(el) {
  	   return (el.face_suit != 5 && el.face_suit != 6);
    });
    // reservePile = reservePile.slice(0,12);
    // NOTE: reservePile length MUST BE A MULTIPLE OF 4 OTHERWISE WE'LL HAVE PROBLEMS
    drawSeveralRundown(4, false);
  }

  $(document).on('turbolinks:load', function() {
    var allowedControllers = ["decks"];
    var allowedActions = ["sorting_game"];
    if (!(jsAllowedOnThisPage(allowedControllers, allowedActions))) {
      return;
    }

    cardInitialData = JSON.parse($("#card-data-div")[0].dataset.cards);
    reservePile = JSON.parse($("#card-data-div")[0].dataset.cards);
    // window.reservePile = JSON.parse($("#card-data-div")[0].dataset.cards);
    window.cardInitialData = JSON.parse($("#card-data-div")[0].dataset.cards);
    // window.goodPile = [];
    // window.roundCards = [];
    // window.discardPile = [];
    // window.stupidPile = [];

    startGame();
  });
})();
