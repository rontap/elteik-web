class Game {
  static state = {

  };
  constructor(state) {
    Game.state = state;
  }
}

let ctx = canv.getContext('2d');
canv.width = 400;
canv.height = 400;
const thisGame = new Game({});
