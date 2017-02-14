var Error = function() {

  var element = document.getElementById('error');
  var dismiss = document.getElementById('dismiss-error');

  var show = function() {
    element.style.display = 'block';
  }

  var hide = function() {
    element.style.display = 'none';
  }

  var onDismiss = function(callback) {
    dismiss.addEventListener('click', function() {
        hide();
        callback();
    });
  }

  hide();

  return {
    element: element,
    show: show,
    hide: hide,
    onDismiss: onDismiss
  }
}

var LoginForm = function() {

  var submit = document.getElementById('submit');
  var username = document.getElementById('username');
  var password = document.getElementById('password');
  
  var prepareSubmit = function(callback) {
      submit.addEventListener('click', callback);
  };
  
  var retrieveCredentials = function() {
      return {username: username.value, password: password.value};
  };
  
  var focusOnUsername = function() {
    username.focus();
  };

  var empty = function() {
    username.value = '';
    password.value = '';
    focusOnUsername();
  }

  return {
    submit: submit,
    username: username,
    password: password,
    prepareSubmit: prepareSubmit,
    retrieveCredentials: retrieveCredentials,
    empty: empty
  }

}

var HOME = '/home.html';
var error;
var loginForm;

main();

function main() {
  document.addEventListener('DOMContentLoaded', preparePage);
}

function preparePage() {
  error = new Error();
  loginForm = new LoginForm();
  error.onDismiss(function() {
    loginForm.empty();
  });
  loginForm.prepareSubmit(doLogin);
}
 
function goToHome() {
  window.location = HOME;
}

function doLogin() {
  var credentials = loginForm.retrieveCredentials();
  if (areValid(credentials)) {
    goToHome();
  } else {
    error.show();
  }
}

function areValid(credentials) {
  return (credentials.username == 'KingRobert') && (credentials.password == 'Stag');
}


