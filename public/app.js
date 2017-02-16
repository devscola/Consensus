var Error = function() {

  var element = document.getElementById('error');
  var dismiss = document.getElementById('dismiss-error');

  var show = function() {
    element.style.display = 'block';
  }

  var hide = function() {
    element.style.display = 'none';
  }

  dismiss.addEventListener('click', function() {
    hide();
    Bus.publish('dismissed');
  });

  hide();

  return {
    element: element,
    show: show,
    hide: hide
  }
}

var LoginForm = function() {

  var submit = document.getElementById('submit');
  var username = document.getElementById('username');
  var password = document.getElementById('password');
  var togglePasswordTemporaryButton = document.getElementById('togglePassword');
  
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

  var togglePassword = function() {
    if (password.type === 'password') {
      password.type = 'text';
    } else {
      password.type = 'password';
    }
  }

  var doLogin = function() {
    var credentials = retrieveCredentials();
    
    Bus.publish('LoginAttempt', credentials);
  }

  submit.addEventListener('click', doLogin);
  togglePasswordTemporaryButton.addEventListener('click', togglePassword);

  return {
    submit: submit,
    username: username,
    password: password,
    empty: empty
  }
}

var LoginService = function() {

  var hasSucceeded = function(result) {
    return result.valid;
  }

  var login = function(credentials) {
    doRequest('/login', credentials, function(result) {
      var evaluated = hasSucceeded(result);
      Bus.publish('LoginResult', evaluated);
    });
  }

  var doRequest = function(endpoint, credentials, callback) {
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

  Bus.subscribe('LoginAttempt', login);

  return {};
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

  var checkLogin = function(result) {
    if (!result) return showError();

    doLogin();
  }

  error = new Error();
  loginForm = new LoginForm();
  
  new LoginService();

  Bus.subscribe('dismissed', loginForm.empty);
  Bus.subscribe('LoginResult', checkLogin);

  return {}
}

var Bus = {

  topics: [],
  subscribe: function(topic, handler) {
    this.ensureTopic(topic);
    this.subscriptions[topic].push(handler);
  },
  subscriptions: {},
  publish: function(topic, data) {
    this.subscriptions[topic].forEach(function(handler) {
      handler(data);
    });
  },
  ensureTopic: function(topic) {
    if (this.subscriptions[topic]) return;

    this.subscriptions[topic] = [];
    this.topics.push(topic);
  }
}

main();

function main() {

  document.addEventListener('DOMContentLoaded', function() {
    new LoginPage();
  });
}
