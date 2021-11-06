delegate(document.querySelector('table'), "click", "td", action)

/**
 *
 * @param parent : HTMLElement ez egy HTMLElement, egy elem a weboldal fa struktúrájában
 * @param type : GlobalEventHandlers ez a event listener típusa, amire figyelni akarunk. Itt kattintásra figyelünk
 * @param selector : string milyen fajta html elemet kereünk majd a kattintásnál. itt <td>
 * @param handler : function egy függvény, amit majd a delegate meg fog hívni
 */
function delegate(parent, type, selector, handler) {
    /**
     Hozzácsatoljuk a table-höz az egyetelen event listenünket; és beállítjuk, hogy minden onclick-nél ez a függvény meghívódjon.
     Az event az egy 'mágigus' paraméter, amit az EventListener MINDIG megkap amikor meghívódik
     */
    parent.addEventListener(type, function (event) {
        /**
         * Alapból az event.target az a 'pontos' elemet adja vissza, amire kattintottál. A .closest(selector) az elindul felfele a fában, és
         * akkor tér vissza, amikor talál egy <td>-t. Ez itt nem segít semmit;
         * de ha a <td>-n belül lenne egy gomb, vagy kép akkor ez segítene megtalálni az érdekes elemet.
         * @type {Element}
         */
        const targetElement = event.target.closest(selector);

        /**
         * a this.containes() az azért kell, mert a .closest() amit meghívtunk, lehet hogy 'kivándorol' / túlságosan felfele megy a fában.
         * Itt, mivel kb nem tudsz olyan helyre kattintani, ahol nincs előbb-utóbb egy <td>, ezért nem segít semmit;
         * de egy bonyolultabb helyzetben, ez segítene elkerülni hibákat.
         *
         */
        if (this.contains(targetElement)) {
            /**
             * eddig, a 'this' az a <table> HTMLElement volt. Most, a handler-be már nem ezt, hanem a
             * targetElement-et adjuk át, tehát konkrétan azt a <td>-t, amire kattintottál.
             */
            handler.call(targetElement);
        }
    })
}

function action() {
    /**
     * Ha nem egy 'option'-re kattintottunk, akkor nem kell class-okat frissíteni.
     */
    if (this.classList.contains('option')) {
        /**
         * Ha már a mostani <td>-nek a szülője, vagyis abban a sorban - <tr>-ben már van egy .selected element;
         * akkor azt töröljük kio
         */
        if (this.parentElement.querySelector('.selected')) {
            this.parentElement.querySelector('.selected').classList.remove('selected')
        }
        /** a most kattintotthoz viszont adjuk hozzá */
        this.classList.add('selected');
    }

    /**
     * Én úgy döntöttem, hogy minden egyes kattintásnál számoljuk újra az eredményeket. Ennek megvannak az előnyei,
     * de nagy táblázatnál nem lenne hasznos.
     */

    /**
     * Lekérjük az összes sort, de az egy NodeList-et ad vissza. Nekünk tömb kell, ezért tömbbé alakítjuk.
     */
    let guesses = Array.from(document.querySelectorAll('table tr'));
    let filled = true;

    /**
     * végigmegyünk az összes <tr>-en, és felülírjuk az értékét _-val, ha nincs abban a sorban .selected,
     * vagy az értékével (X 1 2) ha van a sorban selected
     */
    guesses = guesses.map(el => {
        const value = el.querySelector('.selected');
        if (!value) {
            /** ha legalább egy elem is üres, akkor megjegyezzük késöbbre, hogy még nincs kész a táblázat.*/
            filled = false;
            return '_';
        }
        return value.innerHTML;
    });

    /**
     * kirírjuk az eredményt, összejoinoljuk a tömböt
     * @type {string}
     */
    guess.innerHTML = guesses.join('');

    if (filled) {
        /**
         * kiválasztjuk azokat az elemeket, amik a tipp és a tényleges érték mezőkben egyeznek;
         * majd ennek a tömbnek a hosszát beírjuk
         */
        correct.innerHTML = guesses.filter(
            (el, i) => el == results.value[i]
        ).length;
    }

}

