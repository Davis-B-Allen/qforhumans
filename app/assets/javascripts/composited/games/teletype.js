(function() {
  var cardInitialData;
  var initialCelebs;
  var availableCards;
  var tickertapeTimer;
  var currentMessage = "";
  var gameState = {};
  var gameIsOver = true;

  function playTypewriterAudio() {
    var audio = document.getElementById('typewriter-audio');
    audio.currentTime = 0;
    audio.play();
  }

  function interruptMessage() {
    clearInterval(tickertapeTimer);
    if (currentMessage.length > 0) {
      $('.teletype-printout').append(currentMessage);
      currentMessage = "";
    }
  }

  function nextChar() {
    var nextChar = ""
    var letter = currentMessage.slice(0,1);
    currentMessage = currentMessage.slice(1,currentMessage.length);
    nextChar = nextChar + letter;
    if (letter === "<") {
      while (letter != ">") {
        letter = currentMessage.slice(0,1);
        currentMessage = currentMessage.slice(1,currentMessage.length);
        nextChar = nextChar + letter;
      }
    }
    return nextChar;
  }

  function teletypePrint(answer, onComplete = null) {
    console.log(answer);
    interruptMessage();
    currentMessage = answer;
    $('.teletype-printout').append("<br>");
    tickertapeTimer = setInterval(function() {
      if (currentMessage.length === 0) {
        clearInterval(tickertapeTimer);
        if (onComplete !== null) {
          onComplete();
        }
      } else {
        var letter = nextChar();
        $('.teletype-printout').append(letter);
        // playTypewriterAudio();
        var ttScreen = document.getElementById("teletype-screen");
        ttScreen.scrollTop = ttScreen.scrollHeight;
      }
    }, 10);
  }

  function chooseCeleb() {
    if (gameState.availableCelebs < 1) {
      gameState.availableCelebs = initialCelebs.slice();
    }
    shuffle(gameState.availableCelebs);

    // Uncomment the below for actual game
    // gameState.currentCeleb = gameState.availableCelebs.pop();
    // For testing with James Bond answers
    gameState.currentCeleb = gameState.availableCelebs.find(function(card) {
      return card.name === "James Bond";
    });

    // initialize available cards on the basis of this celebrity
    var cardsEndpoint = "/celebrities/" + gameState.currentCeleb.id + "/cards";
    // initialize available answers on the basis of this celebrity
    var answersEndpoint = "/celebrities/" + gameState.currentCeleb.id + "/answers";
    $.getJSON(cardsEndpoint, function(cards) {
      console.log("Fetched Cards");
      console.log(cards);
      availableCards = cards;
      $.getJSON(answersEndpoint, function(answers) {
        console.log("Fetched Answers");
        console.log(answers);
        availableAnswers = answers;
        playRound();
      });
    })
  }

  function showQuestionChoicePrompt() {
    $('.teletype-input').children().hide();
    $('.question-choice-buttons').children().hide();
    $('.question-choice-buttons').show();
    $('.tt-q-button').each(function(i, btn) {
      if (i < gameState.currentCards.length) {
        $(btn).show();
      }
    });
    $('.teletype-input').slideDown();
  }

  function askForQuestionInput() {
    var numCards = $('.tt-q-button').length;
    shuffle(gameState.availableCards);
    gameState.currentCards = gameState.availableCards.slice(0,numCards);
    var questionPromptText = "Would you like to ask me:";
    for (var i = 0; i < gameState.currentCards.length; i++) {
      var cardQuestion = gameState.currentCards[i].me_question;
      questionPromptText =  questionPromptText + "<br>" + (i+1) + ": " + cardQuestion
    }
    teletypePrint(questionPromptText, showQuestionChoicePrompt);
  }

  function playRound() {
    if (gameState.availableCards.length > 0) {
      askForQuestionInput();
    } else {
      // gameOver();
    }
  }

  function startRound() {
    gameState.availableCards = cardInitialData.slice();
    gameIsOver = false;
    var roundStartText = "I have decided to impersonate a mystery figure, and you have to figure out who I am. In order to help you do that, I'll allow you to ask me certain questions.";
    teletypePrint(roundStartText, chooseCeleb);
  }

  function onStartGameButtonClick() {
    $('.teletype-input').slideUp();
    var firstTimeText = "Hi, I'm Mycroft, yada yada yada.";
    teletypePrint(firstTimeText, startRound);
  }

  function initializeGameState() {
    gameState.currentCeleb = "";
    gameState.currentCards = [];
    gameState.availableCards = cardInitialData.slice();
    gameState.availableCelebs = initialCelebs.slice();
  }

  $(document).on('turbolinks:load', function() {
    var allowedControllers = ["games"];
    var allowedActions = ["teletype"];
    if (!(jsAllowedOnThisPage(allowedControllers, allowedActions))) {
      return;
    }
    cardInitialData = JSON.parse($("#card-data-div")[0].dataset.cards);
    initialCelebs = JSON.parse($("#celebrities-data-div")[0].dataset.celebrities);
    initializeGameState();
    window.gState = gameState;
  });

  $(document).ready(function() {
    $(document).on('click', '.games-teletype #start-game-button', onStartGameButtonClick);
  });

}());
