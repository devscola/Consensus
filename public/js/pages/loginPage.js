var LoginPage = function() {

    var wrongCredentials;
    var loginForm;
    var HOME = '/home.html';

    var goToHome = function() {
        window.location = HOME;
    };

    var showError = function() {
        wrongCredentials.show();
    };

    var doLogin = function() {
        wrongCredentials.hide();
        goToHome();
    };

    var checkLogin = function(result) {
        if (!result) return showError();

        doLogin();
    };

    wrongCredentials = new WrongCredentials();
    loginForm = new LoginForm();

    new LoginService();

    Bus.subscribe('dismissed', loginForm.empty);
    Bus.subscribe('LoginResult', checkLogin);

};
