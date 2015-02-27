codebreaker = function(code){
  this.code = code.split(" ");

  this.guess = function guess(guessStr) {
    var guessArr = guessStr.split(" "),
      score = [];
    var codeCopy = this.code.slice(0);
    for (var i = 0; i < guessArr.length; i++) {
      var codeElement = this.code[i],
        guessElement = guessArr[i];

      if (codeElement === guessElement) {
        score.push("x");
        deleteElement(codeCopy, guessElement);
      } else if (codeCopy.indexOf(guessElement) > -1) {
        score.push("o");
        deleteElement(codeCopy, guessElement);
      }
    }
    score.sort(compareElements);

    return score.join("");

    function deleteElement(arr, element) {
      arr.splice(arr.indexOf(element), 1);
    }
  };

  function compareElements(a, b) {
    return a < b;
  }

};

module.exports = codebreaker;
