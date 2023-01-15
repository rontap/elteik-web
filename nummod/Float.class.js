class Float {
    constructor(m, km, kx) {
        this.m = m;
        this.km = km;
        this.kx = kx;
    }

    repr() {

    }

    print_repr(bin, kar) {
        return `[ ${bin} | ${kar} ]`;
    }

    e0(print = console.log) {
        print('ε<sub>0</sub> - legkisebb szám (0-án kívül) amit lehet reprezentálni' , true);
        print(this.print_repr(this.e0_val, this.km));
        const calc = ('(' + this.eval_repr(this.e0_val) + `) * 2**${this.km}`)
        print(' Számolás: ' + calc)
        print(' Értéke: ' + eval(calc))
    }

    minf(print = console.log) {
        print('m<sub>∞</sub> - legnagyobb szám amit lehet reprezentálni' , true);
        const minf_val = this.getones(this.m);
        print(this.print_repr(minf_val, this.kx));
        const calc = '(' + this.eval_repr(minf_val) + `) * 2**${this.kx}`
        print(' Számolás: ' + calc)
        print(' Értéke: ' + eval(calc))
    }

    e1(print = console.log) {
        print('ε<sub>1</sub> - legkisebb lépésköz, relatív számábrázolási hiba' , true);
        const next = '1' + this.getzeros(this.m - 2) + '1';
        print(this.print_repr(this.e0_val, 1) + ' - ' + this.print_repr(next, 1));
        const calc = ` 2 **(1-${this.m})`;
        print(' Számolás: ' + calc)
        print(' Értéke: ' + eval(calc))

    }

    mamount(print = console.log) {
        print('|M| - gépi számhalmaz számossága' , true);
        const calc = `2 * (2**${this.m - 1}) * ( ${this.kx} - ${this.km} + 1)  +1`
        print(' Számolás: ' + calc)
        print(' Értéke: ' + eval(calc))
    }

    eval_repr(aRepr) {
        return aRepr.split('').map(this.eval_nth).join('').slice(0, -1);
    }

    eval_nth(isTrue, nth) {
        if (isTrue === '1') {
            return `(1/${Math.pow(2, nth + 1)})+`
        } else return '';
    }

    get e0_val() {
        return '1' + this.getzeros(this.m - 1);
    }

    getzeros(nth) {
        return '0'.repeat(nth)
    }

    getones(nth) {
        return '1'.repeat(nth)
    }
}