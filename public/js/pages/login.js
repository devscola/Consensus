var LoginPage = function() {
    new Login.Form();
    new Login.Warning();
    new Login.WarningDismisser();
    new Services.Login();

    var HOME = '/';

    var goToHome = function() {
        window.location = HOME;
    };

    var doLogin = function() {
        goToHome();
    };

    var checkLogin = function(result) {
        if (!result) {
            Bus.publish('warning.show');
            return;
        }
        doLogin();
    };

    Bus.subscribe('login.result', checkLogin);
};
