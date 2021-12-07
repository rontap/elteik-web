let t = ['kenyér', 'szalámi', 'alkohol', 'cicaeledel', 'ecet']
const qs = sel => document.querySelector(sel);

function delegate(parent, type, selector, handler) {
    parent.addEventListener(type, function (event) {
        const targetElement = event.target.closest(selector);
        if (this.contains(targetElement)) {
            handler(targetElement);
        }
    })
}

const startsMgh = str => "aeiouíöüóőúéáű".includes(str[0].toLowerCase())

function handleAdd() {
    const str = qs('input[type="text"]').value;
    if (validate(str)) {
        append(str);
        evaluate();
    }
}

function generate() {
    t.forEach(el => qs('ul').innerHTML += `<li>${el}</li>`)
    evaluate()
}

function evaluate() {
    // 6. fel
    qs('#f6').innerHTML = t.length;

    // 7. fel
    // remélem ez elfogadott.
    qs('#f7').innerHTML = new Set(t).size === t.length ? "nincs" : "van"

    // 8. fel
    qs('#f8').innerHTML = t.filter(startsMgh).join(", ")

    // 9. fel
    qs('#f9').innerHTML = t.reduce((acc, curr) => acc.length > curr.length ? acc : curr, "")
}

function append(str) {
    t.push(str);
    qs('ul').innerHTML += `<li>${str}</li>`;
}

function validate(str) {
    if (str.length) {
        qs('#error').style.display = "none";
        return true;
    } else {
        qs('#error').style.display = "block";
        return false;
    }
}

function action(htmlEl) {
    htmlEl.classList.add('done');
}

delegate(qs('ul'), "click", "li", action)
generate();
qs('button').addEventListener("click", handleAdd);