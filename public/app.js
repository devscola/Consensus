var HOME = '/home.html';
var error = {
  theElement: undefined,
  element: function() {
    if (!this.theElement) {
      this.theElement =  document.getElementById('error');
    }

    return this.theElement;
  },
  show: function() {
    this.element().style.display = 'block';
  },
  hide: function() {
    this.element().style.display = 'none';
  }
}

var loginForm = {
  submit: function() {
    return document.getElementById('submit');
  },
  username: function() {
    return document.getElementById('username').value;
  },
  password: function() {
    return document.getElementById('password').value;
  },
  prepareSubmit: function(callback) {
    this.submit().addEventListener('click', callback);
  },
  retrieveCredentials: function() {
    return {username: this.username(), password: this.password()};
  }
}

main();

function main() {
  document.addEventListener('DOMContentLoaded', preparePage);
}

function preparePage() {
  error.hide();
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


