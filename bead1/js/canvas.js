const Canvas = {
  unit: 75,//px
  path: 20,
  soff: .75
};
Canvas.u2 = Canvas.unit / 2;
Canvas.pad = Canvas.u2 - Canvas.path / 2;
Canvas.uSoff = Canvas.unit * Canvas.soff;

function asUnit(coord) {
  return (coord + Canvas.soff) * Canvas.unit;
};

function asUnitRect(pos) {
  return [
    (pos.x + Canvas.soff) * Canvas.unit,
    (pos.y + Canvas.soff) * Canvas.unit,
    Canvas.unit,
    Canvas.unit,
  ]
}

class Renderer {
  constructor(ctx, game) {
    this.ctx = ctx;
    this.game = game;

    ctx.canvas.addEventListener("click", this.traceClick.bind(this));
  }

  clear() {
    this.ctx.fill();
    this.ctx.stroke();
    this.ctx.clearRect(0, 0, 1500, 1500);
    this.ctx.beginPath();
    this.ctx.lineWidth = 1;
  }

  renderPlayer(player) {
    console.log(player);
    ctx.beginPath();
    let x = asUnit(player.x) + (player.xl == 1 ? Canvas.path * 2 : Canvas.path);
    let y = asUnit(player.y) + (player.xl == 1 ? Canvas.path * 2 : Canvas.path);
    this.ctx.strokeStyle = player.color;
    this.ctx.fillStyle = player.color;
    this.ctx.lineWidth = 3;
    this.ctx.rect(x, y, 15, 15);
    this.ctx.fill();
    this.ctx.stroke();
  }

  renderTreasure(player, {x, y}, treasure) {
    if (treasure.odd) return;

    ctx.beginPath();
    let xx = asUnit(x) + (Canvas.u2);
    let yy = asUnit(y) + (Canvas.u2);
    this.ctx.strokeStyle = 'white';
    this.ctx.fillStyle = player.color;
    this.ctx.arc(xx, yy, 8, 0, 2 * Math.PI);
    this.ctx.fill();
    this.ctx.stroke();
  }

  renderBtns() {

    this.ctx.fillStyle = '#6b93e8';
    this.ctx.strokeStyle = "black";
    this.ctx.fillRect(0, 0, 1000, 1000);

    if (!this.nextShift) return;
    const d = 20;
    const dd = d * 2;
    for (let i = 2; i < 8; i += 2) {
      this.renderArrow(20, i * Canvas.unit, d, d, 0, dd);
      this.renderArrow(20 + 8 * Canvas.unit, i * Canvas.unit, -d, d, 0, dd);
      this.renderArrow(i * Canvas.unit, 20, d, d, dd, 0);
      this.renderArrow(i * Canvas.unit, 20 + 8 * Canvas.unit, d, -d, dd, 0);
    }


  }

  renderArrow(x, y, dx, dy, ddx, ddy) {
    this.ctx.beginPath();
    this.ctx.moveTo(x + 0, y + 0);
    this.ctx.lineTo(x + dx, y + dy);
    this.ctx.lineTo(x + ddx, y + ddy);
    this.ctx.stroke();
  }

  render(node) {
    if (!node) throw 'cannot render node=null';
    this.renderCell(node);
    this.renderDoors(node);
  }

  renderCell(node) {
    this.ctx.rect(...asUnitRect(node.pos))
    this.ctx.stroke();
  }

  renderDoors(node) {
    ctx.beginPath();
    const [x, y] = [asUnit(node.x), asUnit(node.y)];

    this.ctx.fillStyle = "#3b3b3b";
    this.ctx.fillRect(x, y, Canvas.unit, Canvas.unit);
    this.ctx.strokeStyle = this.getColor(node)
    this.ctx.fillStyle = this.getColor(node)

    this.ctx.rect(x + Canvas.pad, y + Canvas.pad, Canvas.path, Canvas.path)
    if (node.isDoorOpen("NORTH")) {
      this.ctx.rect(x + Canvas.pad, y, Canvas.path, Canvas.u2);
    }
    if (node.isDoorOpen("SOUTH")) {
      this.ctx.rect(x + Canvas.pad, y + Canvas.u2, Canvas.path, Canvas.u2);
    }
    if (node.isDoorOpen("EAST")) {
      this.ctx.rect(x, y + Canvas.pad, Canvas.u2, Canvas.path);
    }
    if (node.isDoorOpen("WEST")) {
      this.ctx.rect(x + Canvas.u2, y + Canvas.pad, Canvas.u2, Canvas.path);
    }

    this.ctx.stroke();
    this.ctx.fill();

  }
  getColor(node) {
    if (node.traced) {
      if (this.nextShift) return '#ffc9af';
      else return '#e6ff8d'
    } else {
      if (this.nextShift) return '#c4c4c4';
      else return '#dedede'
    }
  }

  traceClick(evt) {
    const x = Math.floor((evt.offsetX - Canvas.uSoff) / Canvas.unit);
    const y = Math.floor((evt.offsetY - Canvas.uSoff) / Canvas.unit);

    if (clamp(x) !== x || clamp(y) !== y) {
      this.maybeLastMove = this.lastMove;
      this.lastMove = {x, y};

      if (y === -1) return this.game.actShift(x, "DOWN");
      if (y === 7) return this.game.actShift(x, "UP");
      if (x === -1) return this.game.actShift(y, "RIGHT");
      if (x === 7) return this.game.actShift(y, "LEFT")

      this.lastMove = this.maybeLastMove;
    } else {
      this.game.step(x, y);
    }

  }
}
