class Node {
  static get Null() {
    return {
      isNull : true,
      preorder: () => undefined,
      postorder: () => undefined,
      inorder: () => undefined,
      print: () => ""

    }
  }
  static new(value) {
    return new Node(
      value,
      undefined,
      Node.Null,
      Node.Null,
      true,
      0
    );
  }

  constructor(value,parent,left,right,isRoot,offset) {
      this.isNull = false;
      this.isRoot = isRoot || false;
      this.depth = isRoot ? 0 : parent.depth + 1;
      this.parent = parent || false;
      this.value = value;
      this.left = left;
      this.right = right;
      this.offset = offset;
  }
  add(value,isLeft=true) {
      this[isLeft ? 'left' : 'right'] = new Node(
        value,
        this,
        Node.Null,
        Node.Null,
        false,
        (this.offset + (isLeft ? 1 : -1))
      )
      return this;
  }
  addLeft(value) { return this.add(value,true)}
  addRight(value) { return this.add(value,false)}

  get has_left() { return !this.left.isNull }
  get has_right() { return !this.right.isNull }

  max_height() {
    if (this.is_leaf) return this.depth;

    const left = this.left && this.left.max_height();
    const right = this.right && this.right.max_height();

    if (this.left && !this.right) return left;
    if (this.right && !this.left) return right;

    return (left > right) ? left : right;
  }
  get is_leaf() {
    return !this.left && !this.right;
  }

  preorder() {
    return [
      this,
      this.left.preorder() ,
      this.right.preorder()
     ]
  }
  inorder() {
    return [
      this.left.inorder() ,
      this,
      this.right.inorder()
     ]
  }
  postorder() {
    return [
      this.left.postorder() ,
      this.right.postorder(),
      this,
     ]
  }


  print() {
    let _c =`<div><span
    fstyle="left:calc(50% - ${this.offset*(40-(this.depth*3))}px);top:${this.depth*30}px;">
    ${this.value}
    </span><br/><i left>`
    _c += this.left.print() + "</i><i right>";
    _c += this.right.print() + "<i>";
    _c += "</i></div>";

    return _c;
  }


}

class Tree {
  static new(value) {
     return new Tree( Node.new(value ));
  }
  constructor(root) {
    this.root = root;
  }
  get left() {
    return this.root.left;
  }
  get right() {
    return this.root.right;
  }
  get height() {
    return this.root.max_height();
  }
  #order(array) {
    return array.flat(Infinity).filter(_=>_);
  }
  preorder() {
    return this.#order(this.root.preorder());
  }
  postorder() {
    return this.#order(this.root.postorder());
  }
  inorder() {
    return this.#order(this.root.inorder());
  }
  level_order() {
    const q = [this.root];
    const out = [];
    while (q.length) {
      const s = q.shift();
      out.push(s);
      if (!s.left.isNull) q.push(s.left);
      if (!s.right.isNull) q.push(s.right);
    }
    return out;
  }

  print() {
    c.innerHTML =  this.root.print();
  }



}

class SearchTree extends Tree {
    constructor(root) {
      super(root);
    }
    static new(value) {
      return new SearchTree( Node.new(value) ) ;
    }

    add(value,curr = this.root, parent,direction) {
          if (curr.isNull) {
              parent[direction] = new Node(
                value,
                parent,
                Node.Null,
                Node.Null,
                false,
                null
              );
              VERBOSE(`parent Node:`,parent,` : dir:${direction} inserting ${value}`);
          }
          else {
            if (curr.value < value) {
                this.add(value,curr.right,curr,'right');
            }
            else if (curr.value > value) {
                this.add(value,curr.left,curr,'left');
            }
          }
    }
    min(node = this.root) {
      while (!node.left.isNaN) {
        node = node.left;
      }
      return node;
    }
    remMin(node = this.root) {
      console.log('adNode',node.value)
      if (!node.has_left) {
          node.parent.left = node.right;
          node.right = Node.Null
          return node;
      } else {
          VERBOSE('remMin',node.left);
          return this.remMin(node.left);
      }
    }
    delRoot(node = this.root) {
      if (!node.has_left) {
        node.parent.right = node.right;
        node = node.right;
        return;
      }
      if (!node.has_right) {
        node.parent.left = node.left;
        node = node.left;
        return;
      }

      //otherwise
      let min = this.remMin(node.right);
      VERBOSE('min_',min,node);
      let value = min.value;

      min.depth = node.depth;
      min.isRoot = node.isRoot;
      min.offset= node.offset;
      min.value = node.value;
      min.parent  = node.parent;

      node.value = value;

      if (node.isRoot) { this.root = node; };

      console.log(node,this.root,min);
    }



}

class PrQueue {
  constructor(q) {
    this.q = [null,...q];
  }
  parent(index) {
    if (index == 0) { return false; }
    let pos = Math.floor(index/2);
    return {
      pos,
      value:this.q[pos],
      parent:this.parent(pos)
    };
  }
  left(index) {
    let pos = index*2;
    return {
      pos,
      value: this.q[pos]
    }
  }
  add(value) {
    let j = this.q.length;
    this.q.push(value);
    let ind = this.parent(j).pos;

    while ( j > 1 && this.q[ind] < value) {
      console.log(`inserting ${value} || position ${j} <:> ${ind} , value ${this.q[j]} <:> ${this.q[ind]}`);
      [ this.q[ind] , this.q[j] ] =   [ this.q[j] , this.q[ind] ];
      j = ind;
      ind = this.parent(ind).pos;
    }
    return this;
  }
  sink(k_index=1,n=this.q.length) {

    let i = k_index;
    let j = this.left(k_index).pos;
    let b = true;


    while (j <= n && b) {
         console.log({i,j,b,n},`comapring : ${this.q[i]} < ${this.q[j]} || ${this.q[j+1]}`)
        if (j < n && this.q[j+1] > this.q[j]) {

          j++;
        }
        if (this.q[i] < this.q[j]) {
          [ this.q[i] , this.q[j] ] = [ this.q[j] , this.q[i] ];
          i = j;
          j = this.left(j).pos;
          console.log('sinking[*]')
        }
        else {
          b = false;

        }
    }
      console.log('<sink>::called: index|n',k_index,n,'::',this.q);
    return this;
  }
  rem_max() {
    let max = this.q[1];
    this.q[1] = this.q.pop();
    console.log('trunk',this.q);
    this.sink(1,this.q.length-1);
    return max;
  }

  static sort(array) {
    let a = new PrQueue(array);
    for (let i = array.length-1; i >= 0 ; i--) {
      array[i] = a.rem_max();
    }
    return array;
  }

  build_max_heap() {
    let n = this.q.length-1;
    for ( let i = this.parent(n).pos ; i>=1 ;i-- ) {
      this.sink(i,n);
    }
    return this;
  }
  heap_sort() {
    this.build_max_heap();
    let n = this.q.length-1;
    let m = n;

    while (m > 1) {
        [ this.q[1] , this.q[m] ] = [ this.q[m] , this.q[1] ];
        m--;
        this.sink(1,m);
        console.log(`heap_sort::${m} of ${n}`,this.q);
    }
    return this;
  }

}

let VERBOSE = () => false;

let st = SearchTree.new(19);
[19,2, 17, 30, 10, 21, 12, 42, 25, 33, 34].map(e => st.add(e))
//setTimeout( ()=> st.print() , 100)
let prq = new PrQueue([8, 6, 7, 6, 5, 3, 4, 4, 1, 3, 5, 2]);
let prq_test = new PrQueue([40,26,27,21,14,15,2,9,6,3,8,10]);
prq_test.add(61);
//prq.add(8);
//prq.add(2);
//prq.add(9);

let prq_heap = new PrQueue([18,23,51,42,14,35,97,53,60,19]);
Array.prototype.values = function(value="value"){return this.map(a => a[value]);}



log = () => {VERBOSE = console.log;}
//let a = Tree.new(4)
//a.root.inorder().map(el => isNaN(el) ? el.join("()").replace(/,/g,"()") : el).join("").replace(/\)[0-9]/g,"$0")
//egyszerű zárojelezés

//let a = Tree.new(3)
/*
a.root.addLeft(2)
a.root.addRight(6)
a.root.left.addLeft(1)
a.root.right.addRight(7)
a.root.right.addLeft(4)
a.root.right.left.addRight(5)
a.root.right.left.right.addRight(9)
a.root.right.left.right.addLeft(15)
*/
/*///inorder
a.root.addLeft(2)
a.root.addRight(6)
a.root.left.addLeft(1)
a.root.left.addRight(3)
a.root.right.addLeft(5)
a.root.right.addRight(7)
*/
let a = Tree.new(1)
a.root.addLeft(2)
a.root.addRight(3)
a.root.left.addLeft(4)
a.root.left.addRight(5)
a.root.right.addLeft(6)
a.root.right.addRight(7)

//a.root.left.left.add(89,false)
//a.root.left.addRight(6)
//a.root.left.right.add(89)
