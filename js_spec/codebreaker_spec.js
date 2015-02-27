var codebreaker = require("../js_lib/codebreaker");

describe("codebreaker", function() {
  it("is instantiated with a code", function() {
    var game = new codebreaker("a b c d");
    expect(game.code).toEqual(["a","b","c","d"]);
  });

  describe("guess()", function(){
    describe('with unique characters', function(){
      var game = null;

      beforeEach(function(){
        game = new codebreaker("a b c d");
      });

      it("returns a blank string for no matches", function(){
        expect(game.guess("w x y z")).toEqual("");
      });

      it("gives all x(s) for a complete match", function(){
        expect(game.guess("a b c d")).toEqual("xxxx");
      });

      it("returns one x for each direct match", function(){
        expect(game.guess("a b x y")).toEqual("xx");
      });

      it("returns o characters for right-char-wrong-spot", function(){
        expect(game.guess("b a d c")).toEqual("oooo");
      });

      it("can mix x and o results", function(){
        expect(game.guess("a d c x")).toEqual("xxo");
      });
    });

    describe('with duplicated characters', function(){
      var game = null;

      beforeEach(function(){
        game = new codebreaker("a a c c");
      });

      it("only uses each code char reference once", function(){
        expect(game.guess("a c a a")).toEqual("xoo");
      });
    });
  });

});
