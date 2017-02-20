var LoginForm = function() {

  var submit = document.getElementById('submit');
  var username = document.getElementById('username');
  var password = document.getElementById('password');
  var passwordToggler = document.getElementById('passwordToggler')

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

  var togglePasswordVisibility = function() {
    if (password.type === 'password') {
      password.type = 'text';
      passwordToggler.className = 'eye opened';
    } else {
      password.type = 'password';
      passwordToggler.className = 'eye';
    }
  }

  var doLogin = function() {
    var credentials = retrieveCredentials();
    
    Bus.publish('LoginAttempt', credentials);
  }

  submit.addEventListener('click', doLogin);
  passwordToggler.addEventListener('click', togglePasswordVisibility)

  return {
    submit: submit,
    username: username,
    password: password,
    empty: empty
  }
}
