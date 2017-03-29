var Form = function() {
    var submit = document.getElementById('submit');
    var username = document.getElementById('username');
    var password = document.getElementById('password');
    var passwordToggler = document.getElementById('password-toggler');

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
    };

    var togglePasswordVisibility = function() {
        if (password.type === 'password') {
            openEye();
        } else {
            closeEye();
        }
    };

    var eyeWillBe = function(eyeTypeWanted) {
        return 'glyphicon glyphicon-eye-' + eyeTypeWanted;
    };

    var openEye = function() {
        password.type = 'text';
        passwordToggler.className = eyeWillBe('open');
    };

    var closeEye = function() {
        password.type = 'password';
        passwordToggler.className = eyeWillBe('close');
    };

    var doLogin = function() {
        var credentials = retrieveCredentials();

        Bus.publish('LoginAttempt', credentials);
    };

    submit.addEventListener('click', doLogin);
    passwordToggler.addEventListener('click', togglePasswordVisibility);
};
