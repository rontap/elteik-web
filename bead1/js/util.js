const Util = {

};

String.prototype.shift = function(by) {
  const ar = this.split('');
  ar.unshift( ...ar.splice(-by))
  return ar;
}
