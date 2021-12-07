const filters = [
    {label: 'Blur', filter: 'blur(#px)', min: 0, max: 10, value: 3},
    {label: 'Brightness', filter: 'brightness(#%)', min: 0, max: 500, value: 80},
    {label: 'Contrast', filter: 'contrast(#%)', min: 0, max: 500, value: 200},
    {label: 'Grayscale', filter: 'grayscale(#%)', min: 0, max: 100, value: 50},
    {label: 'Hue rotate', filter: 'hue-rotate(#deg)', min: 0, max: 360, value: 90},
    {label: 'Invert', filter: 'invert(#%)', min: 0, max: 100, value: 80},
    {label: 'Opacity', filter: 'opacity(#%)', min: 0, max: 100, value: 50},
    {label: 'Saturate', filter: 'saturate(#%)', min: 0, max: 500, value: 200},
    {label: 'Sepia', filter: 'sepia(#%)', min: 0, max: 100, value: 50},
];

const theFiltersDiv = document.querySelector('#the-filters')
const theImage = document.querySelector('#the-image')


function render() {
    const c = [...document.querySelectorAll("#the-filters input[type='checkbox']")].map(el => el.checked);
    const l = [...document.querySelectorAll("#the-filters label")].map(el => el.innerText);
    const s = [...document.querySelectorAll("#the-filters input[type='range']")].map(el => Number(el.value));
    let css = "";
    c.forEach((checked, i) => {
        if (checked) {
            css += filters[i].filter.replace('#', s[i]) + ' '
        }
    })
    theImage.style.filter = css;
}

function generate() {
    let ht = "";
    filters.forEach(obj => {
        ht += `<label>
      <input type="checkbox" value="${obj.filter}">
      ${obj.label}
      <input type="range" min="${obj.min}" max="${obj.max}" value="${obj.value}">
    </label>`
    })
    theFiltersDiv.innerHTML = ht;
}

generate();

theFiltersDiv.addEventListener("mousemove", function (event) {
    render();
})
theFiltersDiv.addEventListener("click", function (event) {
    render();
})