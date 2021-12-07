delegate(document.querySelector('table'), "click", "td", action)



function delegate(parent, type,  handler) {
    parent.addEventListener(type, function (event) {
        const targetElement = event.target.closest(selector);
        if (this.contains(targetElement)) {
            handler.call(targetElement);
        }
    })
}

function action() {
    if (this.classList.contains('option')) {
        this.parentElement.querySelector('.selected')?.classList.remove('selected')
        this.classList.add('selected');
    }

    let guesses = Array.from(document.querySelectorAll('table tr'));
    let filled = true;

    guesses = guesses.map(el => {
        const value = el.querySelector('.selected');
        if (!value) {
            filled = false;
            return '_';
        }
        return value.innerHTML;
    });

    guess.innerHTML = guesses.join('');

    if (filled) {
        correct.innerHTML = guesses.filter((el, i) => el == results.value[i]).length;
    }

}

