const Canvas = {
  unit: 75,//px
  path: 20
};
Canvas.u2 = Canvas.unit / 2;
Canvas.pad = Canvas.u2 - Canvas.path / 2;


function asUnit(coord) {
  return coord * Canvas.unit;
};

function asUnitRect(pos) {
  return [
    pos.x * Canvas.unit,
    pos.y * Canvas.unit,
    Canvas.unit,
    Canvas.unit,
  ]
}

class Renderer {
  constructor(ctx) {
    this.ctx = ctx;
  }

  render(node) {
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
}

const r = new Renderer(ctx);
