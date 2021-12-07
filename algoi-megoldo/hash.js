class HashTable {
  static D = Symbol("Delete");
  static E = Symbol("Empty");
  constructor(h,m) {

    this.h = h; //function
    this.arr = new Array(m).fill().map(_=>HashTable.E);
  }
  fill(arr) {
    arr.forEach( el => this.insert(el));
  }
  insert(elem) {
      let first_deleted, pos;
      let i = 0;

      do {
      pos = this.arr[this.next(elem,i)];
      VERBOSE(`it ${i} for ${elem}; trying [${this.next(elem,i,true)}] val ${pos.toString()}; first_D ${first_deleted}`);
      if (pos == elem) {
        return false;
      }
      if ( pos == HashTable.E ) {
        if ( first_deleted == undefined) {
            this.arr[this.next(elem,i)] = elem;
            break;
        }
        else {
            this.arr[this.next(elem,first_deleted)] = elem;
            break;
        }
      }
      if ( pos == HashTable.D && first_deleted==undefined ) {
          first_deleted = i;
      }
      } while ( this.arr.length > ++i );
    //  this.set_h_at(elem);
    return this;
  }
  delete(elem,del = true) {
    let pos;
    let i = 0;
    do {
      pos = this.next_at(elem,i);
      VERBOSE(`it ${i} for ${elem}; trying [${this.next(elem,i,true)}]  value ${pos.toString()}`);
      if ( pos == elem) {
        if (del) this.arr[this.next(elem,i)] = HashTable.D;
        return true;
      }
      if ( pos == HashTable.E ) {
        return false;
      }
    } while (this.arr.length > ++i);
    return false;
  }
  search(elem) {
    return this.delete(elem,false);
  }

  next(k,i) {
      return this.h(this.h(k)+i);
  }

  next_at(k,i) {
    return this.arr[this.next(k,i)];
  }
  h_at(elem) {
    return this.arr[this.h(elem)];
  }
  set_h_at(elem) {
    this.arr[this.h(elem)] = elem;
  }
}

class QHashTable extends HashTable {
  constructor(h,m,c1,c2) {
    super(h,m);
    this.c1 = c1 || 0;
    this.c2 = c2 || 0;
  }
  next(k,i) {
    return this.h(this.h(k)+(i*(this.c1+this.c2*i)));
  }
}
class DHashTable extends HashTable {
  constructor(h,m,h2) {
   super(h,m);
    this.h2 = h2 //fn;

  }
  next(k,i,_VERBOSE) {
    if (_VERBOSE) return (`~ h2(${k})[${this.h2(k)} *i=${i}] h1[${this.h( this.h(k) + i*this.h2(k))}]`);
    return this.h( this.h(k) + i*this.h2(k));
  }
}

let len = 11
let h = new HashTable( k=>k%11 , len)

let hq = new QHashTable( k=>k%8 , 8, 1/2, 1/2)

let hd = new DHashTable( k=>k%11 , 11, k=> (1+k%10) )

let d = new DHashTable( k=>k%11 , 11, k=> (1+k%10) )
