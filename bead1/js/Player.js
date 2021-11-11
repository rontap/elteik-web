class Player {
  static Data = [
    {x: 0, y: 0, color: '#ff4488', xl: -1, yl: -1},
    {x: 6, y: 6, color: '#4488ff', xl: 1, yl: 1},
    {x: 0, y: 6, color: '#37c531', xl: -1, yl: 1},
    {x: 6, y: 0, color: '#ff6a32', xl: 1, yl: -1},
  ];
  static Players = 0;

  constructor() {
    this.id = Player.Players++;
    this.data = Player.Data[this.id];
    //this.goals = Treasure;
  }

  display() {
    return `<div class="player" style="background:${this.data.color+'66'};border-bottom-color:${this.data.color+'cc'}">
        ${this.id} //
    </div>`
  }
  shift({x,y}) {
    this.data.x = clamp( this.data.x + x);
    this.data.y = clamp( this.data.y + y);
  }

  maybePickupTreasure() {
    if ( this.x === this.goals[0].x &&  this.y === this.goals[0].y ) {
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
