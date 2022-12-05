class TreasureStash {
  static New(forPlayers, trPerPlayer = 2) {
    if (24 / forPlayers < trPerPlayer) throw 'Too many players for treasures';
    const allCoords = [];
    const trs = [];
    for (let x = 0; x < 7; x++) {
      for (let y = 0; y < 7; y++) {
        if (((x === y) && y === 0) || ((x === y) && y === 6) || (x === 0 && y === 6) || (x === 6 && y === 0)) continue;
        allCoords.push({x, y});
      }
    }
    allCoords.shuffle();

    for (let i = 0; i < forPlayers; i++) {
      trs.push(fillArray(trPerPlayer, _ => new TreasureStash(allCoords.shift(), i)))
    }
    return trs;
  }

  constructor(coords, ofPlayer) {
    this.coords = coords;
    this.ofPlayer = ofPlayer;
    this.odd = false;
  }

  get x() {
    return this.coords.x;
  }

  get y() {
    return this.coords.y;
  }

  get raw() {
    return this.coords;
  }
}
