class Shape {
  static Type = {
    LINE: "1010",
    ROUND: "0110",
    TSHAPE: "0111"
  };
  static Dir = {
    NORTH: 0,
    EAST: 1,
    SOUTH: 2,
    WEST: 3,
    RANDOM: () => ["NORTH", "EAST", "SOUTH", "WEST"][Math.floor(Math.random() * 3)]
  }

  get raw() {
    return {...this};
  }
  static fromRaw({type,rotation,pos}) {
    return new Shape(type,rotation,pos);
  }

  /**
   *
   * @param type Node.Type
   * @param rotation Node.Dir
   * @param position {x,y}
   */
  constructor(type, rotation = Shape.Dir.RANDOM(), position = {}) {
    this.type = type;
    this.rotation = rotation;
    this.doors = this.getType.shift(this.getRotation);
    this.pos = position;

    if (undef(this.getType)) throw 'Invalid Shape::Type';
    if (undef(this.getRotation)) throw 'Invalid Shape::Rotation';
  }

  setPos(x, y) {
    this.pos = {x, y};

    if (this.treasure) {
      this.treasure.coords = this.pos;
    }
    return this;
  }

  asOdd(to) {
    this.odd = to;
    if (this.treasure) {
      this.treasure.odd = to;
    }
    return this;
  }

  get x() {
    return this.pos.x;
  }

  get y() {
    return this.pos.y;
  }

  get getType() {
    return Shape.Type[this.type];
  }

  get getRotation() {
    return Shape.Dir[this.rotation];
  }

  isDoorOpen(doorName) {
    return this.doors[Shape.Dir[doorName]] === '1';
  }


}

//
// let n1 = new Shape("LINE", "EAST", {x: 2, y: 1});
// let s1 = new Shape("ROUND", "EAST", {x: 3, y: 1});
// let t1 = new Shape("TSHAPE", "EAST", {x: 4, y: 1});
// let t2 = new Shape("TSHAPE", "NORTH", {x: 4, y: 3});



