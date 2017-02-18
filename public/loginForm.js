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
