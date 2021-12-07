const Canvas = {
  unit: 75,//px
  path: 20,
  soff: .75,
  origin: [0, 0]
};
Canvas.u2 = Canvas.unit / 2;
Canvas.pad = Canvas.u2 - Canvas.path / 2;
Canvas.uSoff = Canvas.unit * Canvas.soff;


class Renderer {
  constructor(ctx, game, ignoreCoords = false) {
    this.odd = ignoreCoords;
    this.ctx = ctx;
    this.game = game;

    ctx.canvas.addEventListener("click", this.traceClick.bind(this));
  }

  asUnit(coord) {
    return (coord + Canvas.soff) * Canvas.unit;
  };

  asUnitRect(pos) {
    return [
      (pos.x + Canvas.soff) * Canvas.unit,
      (pos.y + Canvas.soff) * Canvas.unit,
      Canvas.unit,
      Canvas.unit,
    ]
  }

  clear() {
    this.ctx.fill();
    this.ctx.stroke();
    this.ctx.clearRect(0, 0, 1500, 1500);
    this.ctx.beginPath();
    this.ctx.lineWidth = 1;
    this.ctx.strokeStyle = 'black';
    this.ctx.fillStyle = 'black';
  }

  renderPlayer(player,opacity='ff') {
    console.log(player);
    ctx.beginPath();
    let x = this.asUnit(player.x) + (player.xl === 1 ? Canvas.path * 2 : Canvas.path);
    let y = this.asUnit(player.y) + (player.yl === 1 ? Canvas.path * 2 : Canvas.path);
    this.ctx.strokeStyle = player.color+opacity;
    this.ctx.fillStyle = player.color+opacity;
    this.ctx.lineWidth = 3;
    this.ctx.rect(x, y, 15, 15);
    this.ctx.fill();
    this.ctx.stroke();
  }


  renderTreasure(color, {x, y}, treasure) {
    if (!this.odd && treasure.odd) return;

    this.ctx.beginPath();
    let xx = this.odd ? Canvas.u2 : this.asUnit(x) + (Canvas.u2);
    let yy = this.odd ? Canvas.u2 : this.asUnit(y) + (Canvas.u2);
    this.ctx.strokeStyle = 'white';
    this.ctx.fillStyle = color;
    this.ctx.arc(xx, yy, 7, 0, 2 * Math.PI);
    this.ctx.stroke();
    this.ctx.fill();
  }

  animateMove(x,y,traceback,player,cb ){
    let to = 0;
    traceback.reverse();
    let int = setInterval( function() {
      if (to++ > traceback.length+3) {
        clearInterval(int);
        cb(x,y);
        return;
      }

      for (let i = 0 ; i < to ; i++) {
        if (i >= traceback.length) continue;
        player.data.x = traceback[i].x;
        player.data.y = traceback[i].y;
        renderer.renderPlayer(player.data,44);
      }

    }, 90);

  }


  animateSlide(id, direction, node, cb) {
    let img;
    let dx = 0;
    let dy = 0;
    let [ogx, ogy, dimx, dimy] = [-Canvas.uSoff, Canvas.unit * id + Canvas.uSoff, Canvas.unit * 9, Canvas.unit]
    if (direction === "LEFT") {
      dx = -1
    } else if (direction === "RIGHT") {
      dx = 1
    } else {
      [ogx, ogy, dimx, dimy] = [ogy, ogx, dimy, dimx];
      dy = direction === "UP" ? -1 : 1;
    }

    img = this.ctx.getImageData(ogx, ogy, dimx, dimy);
    let dist = 0;
    const int = setInterval(function (that) {
      ogx += dx;
      ogy += dy;
      this.ctx.putImageData(img, ogx, ogy);

      switch (direction) {
        case "UP" :
          node.pos.x = id;
          break;
        case "DOWN" :
          node.pos.x = id;
          break;
        case "LEFT" :
          node.pos.x = 7;
          break;
        case "RIGHT" :
          node.pos.x = -1;
          break;
      }
      switch (direction) {
        case "UP" :
          node.pos.y = 7;
          break;
        case "DOWN" :
          node.pos.y = -1;
          break;
        case "LEFT" :
          node.pos.y = id;
          break;
        case "RIGHT" :
          node.pos.y = id;
          break;
      }
      node.pos.x += (dist / Canvas.unit) * dx;
      node.pos.y += (dist / Canvas.unit) * dy;
      that.render(node)


      if (dist++ > Canvas.unit - 1) {
        clearTimeout(int);
        cb(id, direction);
      }
    }, 8, this)


  }


  renderBtns() {

    this.ctx.fillStyle = '#b0bec5';
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
    this.ctx.rect(...this.asUnitRect(node.pos))
    this.ctx.stroke();
  }

  renderDoors(node) {
    ctx.beginPath();
    const [x, y] = this.odd ? Canvas.origin : [this.asUnit(node.x), this.asUnit(node.y)];

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
      let {dx, dy} = this.counterLastMove();
      if (dx === x && dy === y) return;

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

  counterLastMove() {
    if (!this.lastMove) return {};
    const dx = this.lastMove.x;
    const dy = this.lastMove.y;
    if (dy === -1) return {dx, dy: 7}
    if (dy === 7) return {dx, dy: -1}
    if (dx === -1) return {dx: 7, dy}
    if (dx === 7) return {dx: -1, dy}
  }
}
