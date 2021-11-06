class Node {
  static Type = {
    LINE: "1010",
    ROUND: "0110",
    TSHAPE: "0111"
  };
  static Dir = {
    NORTH: 0,
    EAST: 1,
    SOUTH: 2,
    WEST: 3
  }

  /**
   *
   * @param type Node.Type
   * @param rotation Node.Dir
   * @param position {x,y}
   */
  constructor(type, rotation, position) {
    this.type = type;
    this.rotation = rotation
    this.doors = this.getType.shift(this.getRotation);
    this.pos = position;

  }
  get x() {
    return this.pos.x;
  }
  get y() {
    return this.pos.y;
  }
  get getType() {
    return Node.Type[this.type];
  }
  get getRotation() {
    return Node.Dir[this.rotation];
  }
  isDoorOpen(doorName) {
    return this.doors[Node.Dir[doorName]] === '1';
  }


}

class Map {
  static Size = { x: 7, y: 7};
  constructor() {
    ///this.map;
  }
}

let n1 = new Node("LINE","EAST",{x:2,y:1});
let s1 = new Node("ROUND","EAST",{x:3,y:1});
let t1 = new Node("TSHAPE","EAST",{x:4,y:1});
let t2 = new Node("TSHAPE","NORTH",{x:4,y:3});


const a1 = [n1,s1,t1,t2];
a1.map(a => r.render(a) )
