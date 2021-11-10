class Player {
  static Data = [
    {x: 0, y: 0, color: '#ff4488', xl: -1, yl: -1},
    {x: 6, y: 6, color: '#4488ff', xl: 1, yl: 1},
    {x: 0, y: 6, color: '#206e1d', xl: -1, yl: 1},
    {x: 6, y: 0, color: '#ff4444', xl: 1, yl: -1},
  ];
  static Players = 0;

  constructor() {
    this.id = Player.Players++;
    this.data = Player.Data[this.id];
  }

  display() {
    return `<div class="player" style="background:${this.data.color+'66'};border-bottom-color:${this.data.color+'cc'}">
        ${this.id} //
    </div>`
  }

}
