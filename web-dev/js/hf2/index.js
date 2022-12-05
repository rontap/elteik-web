const textarea = document.querySelector('#text')
const task1 = document.querySelector('#task1')
const task2 = document.querySelector('#task2')
const task3 = document.querySelector('#task3')
const task4 = document.querySelector('#task4')
const task5 = document.querySelector('#task5')

const mgh = 'aáeéiíoóöőuúüűAÁEÉIÍOÓÖŐUÚÜŰ';

function process(v) {
    const va = v.split('');
    //console.log(event.target.value);
    task1.innerHTML = v.length;

    const sentences = va.filter( el => ['.','?','!'].includes(el))

    task2.innerHTML = sentences.length;

    const words = v.split(' ').filter( el => el !== "")

    task3.innerHTML = words.length;

    const isMgh =  words.every( el => el.split('').some( ch => mgh.includes(ch)))

    task4.innerHTML = isMgh;

    const longest = words.reduce( (acc,curr) => acc.length < curr.length ? curr: acc , "")

    task5.innerHTML = longest;

}

function handleKey(event) {
    process(event.target.value);

}

textarea.addEventListener('input' , handleKey);


process(textarea.innerHTML)