var HOME = '/home.html';
var error = {
  theElement: undefined,
  element: function() {
    if (!this.theElement) {
      this.theElement =  document.getElementById('error');
    }
    return this.theElement;
  },
  dismiss: function() {
    return document.getElementById('dismiss-error');
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
    return document.getElementById('username');
  },
  password: function() {
    return document.getElementById('password');
  },
  prepareSubmit: function(callback) {
    this.submit().addEventListener('click', callback);
  },
  retrieveCredentials: function() {
    return {username: this.username().value, password: this.password().value};
  }
}

main();

function main() {
  document.addEventListener('DOMContentLoaded', preparePage);
}

function preparePage() {
  error.hide();
  loginForm.prepareSubmit(doLogin);
  error.dismiss().addEventListener('click', function() {
    error.hide();
    loginForm.username().focus();
  });
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


