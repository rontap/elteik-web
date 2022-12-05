window.onload = function() {
  const btn = `<a role="button" href="#" onclick="dark_mode()" id="night_vision">${localStorage.dark_mode ? "Nappali" : "Esti"} nézet</a>`;
try {
  document.querySelector('nav').innerHTML+=`
    <span id="nav_media">
    <a role="button" href="#" onclick="accessible_mode()">${localStorage.accessible_mode ? "Hagyományos" : "Akadálymentes"} nézet</a>
    ${localStorage.accessible_mode ? "" : btn }
    </span>
  `
} catch(e) { /*a transcription.html -en nincs menü*/}
  console.log(localStorage.accessible_mode)
  if (localStorage.accessible_mode) {
    document.querySelector('head').innerHTML+=`<link rel="stylesheet" href="accessible_mode.css" />`
  }
  else if (localStorage.dark_mode) {
    document.querySelector('head').innerHTML+=`<link rel="stylesheet" href="dark_mode.css" />`
  }
}
function accessible_mode() {
  localStorage.accessible_mode = localStorage.accessible_mode ? "" : "1";
  location.reload();
}
function dark_mode() {
  localStorage.dark_mode = localStorage.dark_mode ? "" : "1";
  location.reload();
}
