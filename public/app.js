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

var LoginForm = function(page) {

  var submit = document.getElementById('submit');
  var username = document.getElementById('username');
  var password = document.getElementById('password');
  
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

  var doLogin = function() {
    var credentials = retrieveCredentials();
    
    LoginService().login(credentials, checkLogin);
  }

  var checkLogin = function(result) {
    if (!result) return page.showError();

    page.doLogin();
  }

  submit.addEventListener('click', doLogin);

  return {
    submit: submit,
    username: username,
    password: password,
    empty: empty
  }

}

var LoginService = function() {

  function hasSucceeded(result) {
    return result.valid;
  }

  function login(credentials, callback) {
    doRequest('/login', credentials, function(result) {
      var evaluated = hasSucceeded(result);
      callback(evaluated);
    });
  }

  function doRequest(endpoint, credentials, callback) {
    var request = new XMLHttpRequest();
    var OK = 200;

    request.open('POST', endpoint);
    request.setRequestHeader('Content-Type', 'application/json');
    request.onreadystatechange = function() {
      if (request.readyState === XMLHttpRequest.DONE) {
        if (request.status === OK) {
          callback (JSON.parse(request.responseText));
        }
      }
    }
    request.send(JSON.stringify(credentials));
  }


  return {
    login: login
  }
}

var LoginPage = function() {

  var error;
  var loginForm;
  var HOME = '/home.html';

  var goToHome = function() {
    window.location = HOME;
  }

  var showError = function() {
    error.show();
  }

  var doLogin = function() {
    error.hide();
    goToHome();
  }

  error = new Error();
  loginForm = new LoginForm({
    showError: showError,
    doLogin: doLogin
  });

  error.onDismiss(function() {
    loginForm.empty();
  });

  return {
    showError: showError,
    doLogin: doLogin
  }
}

main();

function main() {

  document.addEventListener('DOMContentLoaded', function() {
    new LoginPage();
  });
}
