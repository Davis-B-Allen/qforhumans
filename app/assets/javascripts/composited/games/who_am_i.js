(function() {
  var cardInitialData;
  var availableCards;
  var initialCelebs;
  var availableCelebs;
  var availableAnswers;
  var currentCeleb;
  var currentCards;
  var gameIsOver = true;
  var wikiSearchTimer;

  function startGame() {
    $('.replay-box').hide();
    $('#whoami-game-start-button').hide();
    availableCards = JSON.parse($("#card-data-div")[0].dataset.cards);
    // NOTE: TO LIMIT CARD ARRAY TO SUBSET FOR TESTING, uncomment below
    // availableCards = availableCards.slice(0,7);
    gameIsOver = false;
    // choose celeb
    chooseCeleb();


    // NOTE: Commenting out the following as we don't want to start the round
    // until we've fetched the cards and answers for the round, given a celeb
    // start first round
    // playRound(false);
  }

  function gameOver(playerGuessedCorrectly) {
    // check if player guessed correctly. If they did, show you won message, else show you lost message
    if (playerGuessedCorrectly) {
      $('#game-over-message').html("<p>Congratulations! You Won. I was indeed " + currentCeleb.name + ".</p>");
    } else {
      $('#game-over-message').html("<p>Game Over. I'm sorry, you lost. I was " + currentCeleb.name + ".</p>");
    }
    gameIsOver = true;
    $('.replay-box').show();
    $('#whoami-game-start-button').show();
  }

  function chooseCeleb() {
    if (availableCelebs < 1) {
      availableCelebs = initialCelebs.slice();
    }
    shuffle(availableCelebs);


    // Uncomment the below for actual game
    // currentCeleb = availableCelebs.pop();
    // For testing with James Bond answers
    currentCeleb = availableCelebs.find(function(card) {
      return card.name === "James Bond";
    });
    // initialize available cards on the basis of this celebrity
    var cardsEndpoint = "/celebrities/" + currentCeleb.id + "/cards";
    // initialize available answers on the basis of this celebrity
    var answersEndpoint = "/celebrities/" + currentCeleb.id + "/answers";
    $.getJSON(cardsEndpoint, function(cards) {
      console.log("Fetched Cards");
      console.log(cards);
      availableCards = cards;
      $.getJSON(answersEndpoint, function(answers) {
        console.log("Fetched Answers");
        console.log(answers);
        availableAnswers = answers;
        playRound(false);
      });
    })




    $('.debug-celeb-name').html("<p>" + currentCeleb.name + "</p>");
  }

  function playRound(playerGuessedIncorrectly) {
    if (playerGuessedIncorrectly) {
      // show incorrect guess message
      $('#guess-feedback').show();
    } else {
      // hide incorrect guess message
      $('#guess-feedback').hide();
    }
    // console.log(availableCards);
    if (availableCards.length > 0) {
      updateCards();
    } else {
      gameOver(false);
    }
  }

  function updateCards() {
    $('#confirm-card-choice-button').addClass('disabled');
    $('.qcard').removeClass('selected');
    var numCards = $('.qcard').length;
    shuffle(availableCards);
    currentCards = availableCards.slice(0,numCards);
    var numCurrentCards = currentCards.length;
    $('.qcard').each(function(i, card) {
      if (i < numCurrentCards) {
        $(card).show();
        var cardData = currentCards[i];
        updateCardDisplay(card, cardData);
      } else {
        $(card).hide();
      }
    });
    $('.qcard-hand').show(0,'',resizeCardFont);
  }

  function updateCardDisplay(card, cardData) {
    $(card).find("#q-card-name").html("<h1>" + cardData.lens_name + "</h1>");
    $(card).find("#q-card-question").html("<p>" + cardData.me_question + "</p>");
    $(card).find('#q-card-id').attr('data-id', cardData.id);
  }

  function progressivelyDisplayAnswer(answer) {
    $('#qcard-answer-answer').html("");
    var tickertapeTimer;
    tickertapeTimer = setInterval(function() {
      if (answer.length === 0) {
        clearInterval(tickertapeTimer);
      } else {
        var letter = answer.slice(0,1);
        answer = answer.slice(1,answer.length);
        $('#qcard-answer-answer').append(letter);
      }
      console.log("tick");
    }, 50);
  }

  function onConfirmCardChoiceClick() {
    if ($(this).hasClass('disabled')) {
      return;
    }
    // find card ID for card that is selected
    var cardId = parseInt($('.qcard').filter('.selected').find('#q-card-id').attr('data-id'));
    var targetCard = availableCards.find(function(card) {
      return card.id === cardId;
    });

    // fetch an answer with relevant cardId
    // ALSO: if there is only one answer, remove the card from availableCards
    var answers = availableAnswers.filter(function(el) {
       return (el.card_id === cardId);
    });
    console.log(answers);
    shuffle(answers)
    if (answers.length <= 1) {
      var deleteIndex = availableCards.indexOf(targetCard);
      availableCards.splice(deleteIndex,1);
    }
    var currentAnswer = answers.pop();
    var answerDeleteIndex = availableAnswers.indexOf(currentAnswer);
    availableAnswers.splice(answerDeleteIndex,1);

    console.log("remaining available answers: " + availableAnswers.length);
    console.log("remaining available cards: " + availableCards.length);

    // remove card from availableCards set
    // NOTE: in future, only remove card if we are grabbing the ONLY answer belonging to that card
    // var deleteIndex = availableCards.indexOf(targetCard);
    // availableCards.splice(deleteIndex,1);
    // hide qcard hand
    $('.qcard-hand').hide();
    // show answer div
    $('.qcard-answer-box').show();
    // display answer
    // NOTE: placeholder answer for now, in future will pull answer text from targetCard's answers
    var placeholderAnswer = "This is a placeholder answer for a question from a question card";
    $('#qcard-answer-question').html("<p>You asked \"" + targetCard.me_question + "\":<\p>");

    // progressivelyDisplayAnswer(placeholderAnswer);
    console.log(currentAnswer.content);
    progressivelyDisplayAnswer(currentAnswer.content);

    // show playerGuess div
    resetWikiSearchBox();
    $('.player-guess-box').show();
  }

  function onCardClick() {
    if ($(this).hasClass('selected')) {
      $('.qcard').removeClass('selected');
      $('#confirm-card-choice-button').addClass('disabled');
    } else {
      $('.qcard').removeClass('selected');
      $(this).addClass('selected');
      $('#confirm-card-choice-button').removeClass('disabled');
    }
  }

  function resetWikiSearchBox() {
    $('#player-guess')[0].value = "";
    $('.wiki-search-results').html("");
    $('#submit-guess-button').addClass('disabled');
  }

  function onSkipGuessClick() {
    $('.qcard-answer-box').hide();
    $('.player-guess-box').hide();
    playRound(false);
  }

  function isGuessCorrect(guess) {
    // TODO: Make this more sophisticated in checking guess against celeb's name
    return (guess.toLowerCase() === currentCeleb.name.toLowerCase());
  }

  function onSubmitGuessClick() {
    var playerGuess = $('#player-guess')[0].value;
    if ($(this).hasClass('disabled') || playerGuess === "") {
      $(this).addClass('disabled');
      return;
    }
    $('.qcard-answer-box').hide();
    $('.player-guess-box').hide();
    var guessIsCorrect = isGuessCorrect(playerGuess);
    // alert(guessIsCorrect);
    if (guessIsCorrect) {
      gameOver(true);
    } else {
      playRound(true);
    }
  }

  function clearWikiSearchTimer() {
    clearTimeout(wikiSearchTimer);
    $('.wiki-search-results').html("");
  }

  function setWikiSearchTimer(wikiSearchString) {
    $('.wiki-search-results').html("Loading...");
    wikiSearchTimer = setTimeout(function(){
      fetchWikiSearchResults(wikiSearchString);
    }, 1000);
  }

  function fetchWikiSearchResults(wikiSearchString) {
    console.log("Making call to wikipedia API");
    var uriSearchString = encodeURIComponent(wikiSearchString);
    var wikiEndpoint = "https://en.wikipedia.org/w/api.php?action=query&list=search&srsearch=" +
                       uriSearchString +
                       "&format=json&origin=*";
    $.getJSON(wikiEndpoint, function(data) {
      var results = data.query.search.slice(0,5);
      if (results.length < 1) {
        $('.wiki-search-results').html("No wikipedia results found.");
      } else {
        $('.wiki-search-results').html("");
        for (var i = 0; i < results.length; i++) {
          var articleTitle = results[i]['title'];
          var wikiLink = "https://en.wikipedia.org/wiki/" + encodeURIComponent(articleTitle);
          $('.wiki-search-results').append(
            "<a href=\"" + wikiLink + "\" target='_blank'>" + articleTitle + "</a><br>"
          );
        }
      }
    });
  }

  function onPlayerGuessKeyUp() {
    clearWikiSearchTimer();
    if (this.value.length > 0) {
      $('#submit-guess-button').removeClass('disabled');
      setWikiSearchTimer(this.value);
    } else {
      $('#submit-guess-button').addClass('disabled');
    }
  }



  $(document).on('turbolinks:load', function() {
    var allowedControllers = ["games"];
    var allowedActions = ["who_am_i"];
    if (!(jsAllowedOnThisPage(allowedControllers, allowedActions))) {
      return;
    }
    cardInitialData = JSON.parse($("#card-data-div")[0].dataset.cards);
    initialCelebs = JSON.parse($("#celebrities-data-div")[0].dataset.celebrities);
    availableCards = JSON.parse($("#card-data-div")[0].dataset.cards);
    availableCelebs = JSON.parse($("#celebrities-data-div")[0].dataset.celebrities);
    // window.cardInitialData2 = JSON.parse($("#card-data-div")[0].dataset.cards);
    // window.initialCelebs = JSON.parse($("#celebrities-data-div")[0].dataset.celebrities);
    // window.availableCards = JSON.parse($("#card-data-div")[0].dataset.cards);
    // window.availableCelebs = JSON.parse($("#celebrities-data-div")[0].dataset.celebrities);
  });

  $(document).ready(function() {
    $(document).on('click', '#whoami-game-start-button', startGame);
    $(document).on('click', '#confirm-card-choice-button', onConfirmCardChoiceClick);
    $(document).on('click', '.qcard', onCardClick);
    $(document).on('click', '#skip-guess-button', onSkipGuessClick);
    $(document).on('click', '#submit-guess-button', onSubmitGuessClick);
    $(document).on('keyup', '#player-guess', onPlayerGuessKeyUp);
  });

}());
