// noinspection JSSuspiciousNameCombination

const table = document.querySelector('table');

function xyCoord(td) {
    return {
        x: td.cellIndex,
        y: td.parentNode.sectionRowIndex,
    }
}

function delegate(parent, type, selector, handler) {
    parent.addEventListener(type, function (event) {
        const targetElement = event.target.closest(selector);

        if (this.contains(targetElement)) {
            handler.call(targetElement, event);
        }
    });
}

function render() {
    [...table.querySelectorAll('input')].forEach(el => {
        if (el.checked) el.parentElement.classList.add('present')
        else el.parentElement.classList.remove('present')
    })
}

function hand(evt) {
    if (evt.target.nodeName === 'TD') evt.target.children[0]?.focus();
    else evt.target.focus()

    render();
}

function keyhand(evt) {
    if (evt.target.parentNode.nodeName !== 'TD') return;

    const xy = xyCoord(evt.target.parentNode)
    console.log(xy);

    const newCoords = normalise(dir(evt.key, xy))

    console.log(newCoords);
    const el = table.querySelectorAll('tr')[newCoords.y + 1].children[newCoords.x];
    console.log(el);
    el.children[0].focus()
}

function normalise({x, y}) {
    const w = table.querySelectorAll('tr').length - 1;
    const h = table.querySelectorAll('td').length / w - 1;
    return {
        x: x > h ? 1 : (x < 1 ? h : x),
        y: y > w - 1 ? 0 : (y < 0 ? w - 1 : y),
    }
}

function dir(key, xy) {
    switch (key) {
        case 'ArrowRight' :
            return {x: xy.x + 1, y: xy.y};
        case 'ArrowLeft' :
            return {x: xy.x - 1, y: xy.y};
        case 'ArrowUp' :
            return {x: xy.x, y: xy.y - 1};
        case 'ArrowDown' :
            return {x: xy.x, y: xy.y + 1};
        default:
            return xy;
    }
}

render();
delegate(table, 'click', 'td', hand)
delegate(table, 'keyup', 'td', keyhand)