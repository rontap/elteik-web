const Util = {};

String.prototype.shift = function (by) {
  const ar = this.split('');
  ar.unshift(...ar.splice(-by))
  return ar;
}

Array.prototype.shiftBy = function (by) {
  this.unshift(...this.splice(-by))
  return this;
}

function transpose(matrix) {
  return matrix[0].map((col, i) => matrix.map(row => row[i]));
}

function fillArray(length, mapper) {
  return new Array(length).fill(null).map(mapper);
}

Array.prototype.shuffle = function () {
  let i = this.length, randomIndex;

  while (i != 0) {
    randomIndex = Math.floor(Math.random() * i);
    i--;
    [this[i], this[randomIndex]] = [
      this[randomIndex], this[i]];
  }

  return this;
}

function undef(a) {
  return a === undefined
}

/**
 *
 * @param number
 * @param overturn
 * @param from
 * @param to
 */
function clamp(number, overturn = true, from = 0, to = 6) {
  if (overturn) {
    return number > to ? (number%to)-1 : number < from ? to+(number%to)+1 : number;
  } else {
    return number > to ? to : number < from ? from : number;
  }
}

function xyeq(x,y) {
  return x +","+ y;
}
