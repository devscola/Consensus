var LoginPage = function() {

    var warning;
    var form;
    var HOME = '/';

    var goToHome = function() {
        window.location = HOME;
    };

    var showError = function() {
        warning.show();
    };

    var doLogin = function() {
        warning.hide();
        goToHome();
    };

    var checkLogin = function(result) {
        if (!result) return showError();

        doLogin();
    };

    warning = new Warning();
    form = new Form();

    new LoginService();

    Bus.subscribe('dismissed', form.empty);
    Bus.subscribe('LoginResult', checkLogin);

};
