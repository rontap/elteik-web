function beginGame() {


  window.ctx = canv.getContext('2d');
  let dim = Canvas.unit * 8.5;
  canv.width = dim;
  canv.height = dim;
  canv.style.width = dim + 'px';
  canv.style.height = dim + 'px';

  window.ctx2 = canvOdd.getContext('2d');
  dim = Canvas.unit;
  canvOdd.width = dim;
  canvOdd.height = dim;
  canvOdd.style.width = dim + 'px';
  canvOdd.style.height = dim + 'px';
//const thisGame = new Game({});

  let rawPlayers = [new Player(), new Player(), new Player(), new Player()]
  window.theGame = new Game( rawPlayers.slice(0,players), Number(notrs.value));
  window.renderer = new Renderer(ctx, theGame);
  window.rendererOdd = new Renderer(ctx2, theGame, true);
//const a1 = [n1, s1, t1, t2];
  theGame.render();
//a1.map(a => r.render(a) )
  odd.classList.remove('no');
  control.classList.remove('no');
  canv.classList.remove('no');
  mainScreen.classList.add('no');

}

//beginGame();

let players;
function setPlayers(event) {
  players = Number(event.target.value);
  notrs.innerHTML = "";
  for (let i = 1 ; i < 24/players ; i++) {
    notrs.innerHTML+=`<option ${i===2?'selected':''} value='${i}'>${i} per player</option>`
  }
}
setPlayers({target:{value:2}});

function load() {
  if (localStorage.gs) {
    beginGame();
    theGame.fromJSON( JSON.parse(localStorage.gs) )
  } else {
    alert('no saves available!');
  }
}
function save() {
  if (theGame.save())
  alert('saved!')
}
function showHelp() {
  descriptionRules.classList.remove('no');
  mainScreen.classList.add('no');
}
function hideHelp() {
  mainScreen.classList.remove('no');
  descriptionRules.classList.add('no');
}

if (!localStorage.gs) saved.classList.add('no');
