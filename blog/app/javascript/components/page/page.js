import "./page.css"

windows.onload = function() {
  let elem = document.getElementById('hello');
  console.log(elem.innerText);
  document.body.insertAdjacementHTML("afterbegin", elem.innerText);
}
