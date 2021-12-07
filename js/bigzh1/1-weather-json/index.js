const textarea = document.querySelector('#the-textarea');
const button = document.querySelector('#the-button');
const task1 = document.querySelector('#task1')
const task2 = document.querySelector('#task2')
const task3 = document.querySelector('#task3')
const task4 = document.querySelector('#task4')
const task5 = document.querySelector('#task5')

let dat = {};

function process() {
    dat = JSON.parse(textarea.value);
    console.log('->> PROCESS')
    t1();
    t2();
    t3();
    t4();
    t5();
}

function t1() {
    let d;
    d = dat.daily.filter(el => {
        console.log(el.wind_deg)
        if (el.wind_deg > 135 && el.wind_deg < 225) {
            if (el.clouds > 0) {
                return true;
            }
        }
        return false;
    })

    task1.innerHTML = d[0].dt ?? 'no';
}

function t2() {
    const sm = dat.daily.reduce((acc, r) => r.temp.max < acc.temp.max ? r : acc, dat.daily[0])
    console.log(sm);
    task2.innerHTML = sm.temp.max;
}

function t3() {
    const all = dat.daily.every(el => {
        console.log('p', el.pressure);
        return el.pressure > 1010;
    });
    console.log(all, dat.daily[0].pressure)
    task3.innerHTML = all ? 'Igen' : 'Nem'
}

function t4() {
    const avg = dat.daily.reduce((acc, r) => {
        return acc + r.feels_like.day
    }, 0)
    const v = avg / dat.daily.length;
    task4.innerHTML = v;
}

function t5() {
    console.log(dat);
    const no = dat.hourly.filter(r => r.wind_speed > 3).length
    task5.innerHTML = no;
}

button.addEventListener("click", process)

process()
console.log(dat);