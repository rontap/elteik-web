class Game {
  constructor(players) {
    this.players = players || [];
    this.setDefaultState();
    this.fillEmpty();
  }

  setDefaultState() {
    this.state = fillArray(7, () => fillArray(7, () => null));
    [
      //x , y   TYPE ,  rotation
      [0, 0, "ROUND", "EAST"],
      [2, 0, "TSHAPE", "NORTH"],
      [4, 0, "TSHAPE", "NORTH"],
      [6, 0, "ROUND", "NORTH"],
      //
      [0, 2, "TSHAPE", "EAST"],
      [2, 2, "TSHAPE", "EAST"],
      [4, 2, "TSHAPE", "NORTH"],
      [6, 2, "TSHAPE", "WEST"],

      [0, 4, "TSHAPE", "EAST"],
      [2, 4, "TSHAPE", "SOUTH"],
      [4, 4, "TSHAPE", "WEST"],
      [6, 4, "TSHAPE", "WEST"],
      //
      [0, 6, "ROUND", "SOUTH"],
      [2, 6, "TSHAPE", "SOUTH"],
      [4, 6, "TSHAPE", "SOUTH"],
      [6, 6, "ROUND", "WEST"],
    ].forEach(el => this.fillSlot(...el))
  }

  static getMovables() {
    return [
      ...fillArray(13, () => new Shape("LINE")),
      ...fillArray(15, () => new Shape("ROUND")),
      ...fillArray(6, () => new Shape("TSHAPE")),
    ].shuffle();
  }

  fillEmpty() {
    const field = Game.getMovables();
    this.forEach((el, _, i, j) => {
      if (!el) this.state[i][j] = field.pop().setPos(i, j);
    })
    if (field.length !== 1) throw 'Bad Movable Amounts'
    this.oddOneOut = field[0];
  }

  forEach(lamdba) {
    this.state.forEach((row, i) => {
      row.forEach((el, j) => lamdba(el, row, i, j));
    })
  }

  fillSlot(x, y, type, rotation = 0) {
    this.state[x][y] = new Shape(type, rotation, {x, y});
  }

  get rowGame() {
    return this.state.flat();
  }

  render() {
    playerspace.innerHTML='';
    this.rowGame.forEach(s => renderer.render(s));
    this.players.forEach(s => {
      renderer.renderPlayer(s.data);
      playerspace.innerHTML += s.display();
    });
  }

  trace(player) {
    this.forEach(el => el.traced = false);
    const core = this.state[player.data.x][player.data.y];
    this.traceNext(player.data.x, player.data.y);
    return this;
  }

  traceNext(x, y) {
    const shape = this.state[x][y];
    if (shape.traced) return;
    shape.traced = true;
    if (x < 6 && shape.isDoorOpen("WEST") && this.state[x + 1][y].isDoorOpen("EAST"))
      this.traceNext(x + 1, y)
    if (x > 0 && shape.isDoorOpen("EAST") && this.state[x - 1][y].isDoorOpen("WEST"))
      this.traceNext(x - 1, y)
    if (y > 0 && shape.isDoorOpen("NORTH") && this.state[x][y - 1].isDoorOpen("SOUTH"))
      this.traceNext(x, y - 1)
    if (y < 6 && shape.isDoorOpen("SOUTH") && this.state[x][y + 1].isDoorOpen("NORTH"))
      this.traceNext(x, y + 1)

  };
}


let ctx = canv.getContext('2d');
canv.width = 800;
canv.height = 800;
canv.style.width = '800px';
canv.style.height = '800px';
//const thisGame = new Game({});

const renderer = new Renderer(ctx);
let g = new Game([new Player(), new Player(), new Player(), new Player()]);
//const a1 = [n1, s1, t1, t2];
g.render();
//a1.map(a => r.render(a) )
