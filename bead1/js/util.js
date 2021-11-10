const Util = {

};

String.prototype.shift = function(by) {
  const ar = this.split('');
  ar.unshift( ...ar.splice(-by))
  return ar;
}
function fillArray(length,mapper) {
  return new Array(length).fill(null).map( mapper);
}
Array.prototype.shuffle = function() {
  let i = this.length,  randomIndex;

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
