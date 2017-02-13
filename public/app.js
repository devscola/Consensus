var HOME = '/home.html';
preparePage();

function preparePage() {
  document.addEventListener('DOMContentLoaded', prepareSubmit);  
}

function prepareSubmit() {
  var submit = document.getElementById('submit');
  submit.addEventListener('click', doLogin);
}
  
function goToHome() {
  window.location = HOME;
}

function doLogin() {
  goToHome();
}
