class Player {
  static Data = [
    {x: 0, y: 0, color: '#ff4488', sc: '#ff76a8', xl: -1, yl: -1},
    {x: 6, y: 6, color: '#4488ff',sc: '#7eadff', xl: 1, yl: 1},
    {x: 0, y: 6, color: '#37c531',sc: '#77f174', xl: -1, yl: 1},
    {x: 6, y: 0, color: '#ff6a32',sc: '#fc9a74', xl: 1, yl: -1},
  ];
  static Players = 0;

  constructor(data, goals) {
    this.id = Player.Players++;
    this.data = data || Player.Data[this.id];
    if (goals) {
      this.goals = goals.map(goal => new TreasureStash(goal, this.id));

    }
  }

  get raw() {
    return {...this};
  }

  display(game, isActive, awaitingNext) {
    const left = this.goals.length > 1 ? `${this.goals.length - 1} Left / ${Player.cardsPerPlayer} All` : `Move back to base!`
    return `<div class="player ${isActive ? 'active' : ''} ${awaitingNext}" style="background:${this.data.sc};border-bottom-color:${this.data.color + 'cc'}">
        Player ${this.id + 1} //<br/>
        Treasures<br/>
        ${left}

    </div>`
  }

  shift({x, y}) {
    this.data.x = clamp(this.data.x + x);
    this.data.y = clamp(this.data.y + y);
  }

  maybePickupTreasure() {
    if (this.x === this.goals[0].x && this.y === this.goals[0].y) {
      delete this.goals.shift();
      if (this.goals.length === 0) return true;
    }
    return false;
  };

  get x() {
    return this.data.x;
  }

  get y() {
    return this.data.y;
  }

}
