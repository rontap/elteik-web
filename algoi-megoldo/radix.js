
// radix sort
// stable S1L
function radix_sort(list, d,r) {
  for (let i = d; i>0 ; i-- ) {
      list = bucketise(list,i,r);
      console.log(   {i,list,buckets:list.merge()} );
      list = list.merge()
  }
  return list;
}

const bucketise = (list,d,r) =>
  Array(r).fill(undefined).map(
    (_,i) => list.filter( el => Number((el)[d-1]) === i)
  );

//counting sort
function counting_sort(list,r) {
  for (let i=list[0].length; i>0; i--) {
    list = counting_iter(list,i,r);
  }
  return list;

}

function counting_iter(list,d,r) {
   let count = Array(r).fill(0);
   let out = Array(list.length).fill(0);

    for (let i =0 ; i< list.length;i++) {
      count[ key(list[i], d)]++
    }

    let sum = count[0];
    for ( let i = 1; i< r; i++) {
      count[i] = (sum+=count[i]);
    }

    let sum_count = [...count];
    for (let i = list.length-1 ; i>=0 ; i--) {
      const k = key(list[i],d);
      count[k]--;
      out[count[k]] = list[i];
    }
  console.log({d,count,out,sum_count});
  return out;
}

function key(num,d) {
  return num[d-1]
}


Array.prototype.merge = function(){return this.flat(Infinity)};
