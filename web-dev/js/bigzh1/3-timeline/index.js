const animButton = document.querySelector('#animation');
const leftButton = document.querySelector('#left');
const rightButton = document.querySelector('#right');
const canvas = document.querySelector('canvas');
const ctx = canvas.getContext('2d');

let pixelsPerYear = 5;
let origoYear = 1000;
let dt = 0.2;
let redline = 50;

function as(year) {
    return (year - origoYear) * pixelsPerYear;
}

let cx = canvas.width;
let cy = canvas.height;

function render() {
    //render redlines

    ctx.clearRect(0, 0, 1500 * pixelsPerYear, cy);
    for (let i = 0; i < Infinity; i++) {
        let px = i * (pixelsPerYear * redline) - (origoYear - 1000) * pixelsPerYear
        ctx.beginPath();
        ctx.strokeStyle = '#ff0000';
        ctx.moveTo(px, 0)
        ctx.lineTo(px, cx)
        ctx.stroke();
        ctx.beginPath();
        ctx.fillText(1000 + (i * redline), px, 10);
        ctx.strokeStyle = '#000000';
        ctx.stroke();
        if (1000 + (i * redline) >= 1500) break;
    }

    arpads.forEach(king => processKing(1, king))
    plantanegets.forEach(king => processKing(2, king))
}

const style = ["#59e759", "#d55f5f"];

function processKing(id, king) {
    let xdelta = id * 60;
    let from = as(king.from);
    let to = as(king.to);
    ctx.beginPath();
    ctx.lineWidth = 1;
    ctx.strokeStyle = "#000000";
    ctx.fillStyle = style[id - 1]
    ctx.rect(from, xdelta - 5, to - from, 50);
    ctx.stroke();
    ctx.fill();

    ctx.beginPath();
    ctx.fillStyle = '#000000'
    ctx.fillText(king.name, from, xdelta + 5);
    ctx.fillText(king.from + "-" + king.to, from, xdelta + 35);

    ctx.stroke()
}

let loop;

function anim(start) {
    if (start) {
        loop = setInterval(function () {
            origoYear += dt;
            render()

        }, 15);
    } else clearInterval(loop);
}

leftButton.addEventListener("click", function () {
    origoYear -= 10;
    anim(false)
    render();
})
rightButton.addEventListener("click", function () {
    origoYear += 10;
    anim(false)
    render();
})
animButton.addEventListener("click", function () {
    anim(true)
});
render()
