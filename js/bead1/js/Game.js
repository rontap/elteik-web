class Game {
  static Move = {
    UP: {x: 0, y: -1},
    DOWN: {x: 0, y: 1},
    LEFT: {x: -1, y: 0},
    RIGHT: {x: 1, y: 0},
  }

  constructor(players, cardspp) {
    this.players = players || [];
    this.setDefaultState();
    this.fillEmpty();
    this.current = -1;
    this.nextAction = "SHIFT";
    Player.cardsPerPlayer = cardspp;


    const stash = TreasureStash.New(players.length, cardspp)
    this.players.forEach((player, i) => {
      const treasures = stash.shift().concat(new TreasureStash({x: player.x, y: player.y}, i));
      player.goals = treasures;
      treasures.forEach(t =>
        this.state[t.x][t.y].treasure = t
      )
    })

    this.next();
  }

  setDefaultState() {
    this.state = fillArray(7, () => fillArray(7, () => null));
    [
      //x , y   TYPE ,  rotation
      [0, 0, "ROUND", "EAST"], [2, 0, "TSHAPE", "NORTH"], [4, 0, "TSHAPE", "NORTH"], [6, 0, "ROUND", "NORTH"],
      [0, 2, "TSHAPE", "EAST"], [2, 2, "TSHAPE", "EAST"], [4, 2, "TSHAPE", "NORTH"], [6, 2, "TSHAPE", "WEST"],
      [0, 4, "TSHAPE", "EAST"], [2, 4, "TSHAPE", "SOUTH"], [4, 4, "TSHAPE", "WEST"], [6, 4, "TSHAPE", "WEST"],
      [0, 6, "ROUND", "SOUTH"], [2, 6, "TSHAPE", "SOUTH"], [4, 6, "TSHAPE", "SOUTH"], [6, 6, "ROUND", "WEST"],
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

  awaitingAction(action) {
    return this.nextAction === action;
  }

  pump() {
    this.nextAction = this.nextAction === "SHIFT" ? "MOVE" : "SHIFT";
    return this.awaitingAction;
  }

  next() {
    this.current++;
    this.currentPlayer = this.players[this.current % this.players.length];
  }

  actShift(id, direction) {
    if (!this.awaitingAction("SHIFT")) return;
    if (id % 2 === 0) throw 'Cannot shift this row/col';
    renderer.animateSlide(id, direction, this.oddOneOut, this.actShiftCb.bind(this));
  }

  actShiftCb(id, direction) {
    this.shiftMaze(id, direction);
    this.pump();
    this.render();
  }


  step(x, y) {
    if (!this.awaitingAction("MOVE")) return;
    if (!this.state[x][y].traced) return;

    const traceback = [this.state[x][y]];
    while (true) {
      if (traceback.at(-1).traced === 1) break;
      traceback.push(traceback.at(-1).traced);
    }

    renderer.animateMove(x,y,  traceback, this.currentPlayer, this.stepCb.bind(this));

  }
  stepCb(x,y) {

    this.currentPlayer.data.x = x;
    this.currentPlayer.data.y = y;

    const wasLast = this.currentPlayer.maybePickupTreasure();
    if (wasLast) this.currentPlayerWon();

    this.next();
    this.pump();
    this.render();
  }

  currentPlayerWon() {
    alert(`Congratulations!
    Player ${this.currentPlayer.id + 1} won the keys to the kingdom!
    Great Success.
    Start a new game by pressing 'new game'.`);
    delete this.currentPlayer;
  }

  // noinspection FallThroughInSwitchStatementJS
  shiftMaze(id, direction) {

    let odd;
    switch (direction) {
      case "LEFT" :
        this.state = transpose(this.state)
      case "UP" :
        odd = this.state[id].shift();
        this.state[id].push(this.oddOneOut.asOdd(false));
        break;
      case "RIGHT" :
        this.state = transpose(this.state)
      case "DOWN" :
        odd = this.state[id].pop();
        this.state[id] = [this.oddOneOut.asOdd(false)].concat(this.state[id]);
        break;
      //this.currentPlayer.shift(Game.Move[direction])
    }
    if (direction === "LEFT" || direction === "RIGHT") {
      this.state = transpose(this.state);
    }
    this.oddOneOut = odd.asOdd(true);
    this.inferCoords();

    this.players.forEach(p => {
      const val = (direction === "LEFT" || direction === "RIGHT") ? 'y' : 'x';

      if (p.data[val] === id) {
        p.shift(Game.Move[direction]);
      }
    })

    return this;
  }


  inferCoords() {
    this.forEach((el, _, x, y) => el.setPos(x, y));
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
    console.log(this.nextAction)
    renderer.nextShift = this.awaitingAction("SHIFT")
    renderer.clear();
    renderer.renderBtns();
    this.trace(this.currentPlayer);
    playerspace.innerHTML = '';
    this.rowGame.forEach(s => renderer.render(s));
    this.players.forEach(s => {
      renderer.renderPlayer(s.data);
    });
    this.players.forEach(s => {
      renderer.renderTreasure(s.data.color, s.goals[0].coords, s.goals[0]);
      for (let i = 1; i < s.goals.length - 1; i++) {
        renderer.renderTreasure('rgba(124,243,255,0.85)', s.goals[i].coords, s.goals[i]);
      }
      playerspace.innerHTML += s.display(this, this.currentPlayer === s, this.nextAction);
    });
    this.renderOdd()

  }

  renderOdd() {
    this.oddOneOut.traced = false;
    rendererOdd.clear();
    rendererOdd.render(this.oddOneOut);
    if (this.oddOneOut.treasure) {
      const belongsToPlayer = this.players[this.oddOneOut.treasure.ofPlayer];
      let color = 'rgba(124,243,255,0.85)';
      if (belongsToPlayer.goals[0] === this.oddOneOut.treasure) {
        color = Player.Data[belongsToPlayer.id].color;
      }

      rendererOdd.renderTreasure(color, {}, this.oddOneOut.treasure);
    }
  }

  rotate(turn) {
    this.oddOneOut.doors.shiftBy(turn);
    this.renderOdd();
  }

  trace(player) {
    this.forEach(el => el.traced = 0);
    const core = this.state[player.data.x][player.data.y];
    this.traceNext(player.data.x, player.data.y, 1);
    return this;
  }

  traceNext(x, y, traceOrigin) {
    const shape = this.state[x][y];
    if (shape.traced) return;
    shape.traced = traceOrigin;
    if (x < 6 && shape.isDoorOpen("WEST") && this.state[x + 1][y].isDoorOpen("EAST"))
      this.traceNext(x + 1, y, shape)
    if (x > 0 && shape.isDoorOpen("EAST") && this.state[x - 1][y].isDoorOpen("WEST"))
      this.traceNext(x - 1, y, shape)
    if (y > 0 && shape.isDoorOpen("NORTH") && this.state[x][y - 1].isDoorOpen("SOUTH"))
      this.traceNext(x, y - 1, shape)
    if (y < 6 && shape.isDoorOpen("SOUTH") && this.state[x][y + 1].isDoorOpen("NORTH"))
      this.traceNext(x, y + 1, shape)

  };

  toJSON() {
    const gs = {state: [], players: []};
    this.forEach(el => gs.state.push(el.raw));
    this.players.forEach(p => {
      let goals = [];
      p.goals.forEach(goal => goals.push(goal.raw))
      gs.players.push({...p, goals});
    })
    gs.current = this.current;
    gs.nextAction = this.nextAction;
    gs.cardsPerPlayer = Player.cardsPerPlayer;
    return gs;
  }

  fromJSON(gs) {
    Player.Players = 0;
    let x = 0;
    this.forEach((el, _, i, j) => this.state[i][j] = Shape.fromRaw(gs.state[x++]));
    gs.players.map((_, i) =>
      this.players[i] = new Player(gs.players[i].data, gs.players[i].goals)
    )
    this.players.forEach(p => {
      p.goals.forEach(t =>
        this.state[t.x][t.y].treasure = t
      )
    })
    this.current = gs.current;
    this.nextAction = gs.nextAction;
    Player.cardsPerPlayer = gs.cardsPerPlayer;
    this.render();
  }

  save() {
    if (this.nextAction === "MOVE") return alert("please finish moving before saving!");

    const gs = this.toJSON();
    localStorage.gs = JSON.stringify(gs);
    return true;
  }
}

