var LoginPage = function() {
    new Services.Login();
    new Form();
    new Login.Warning();
    new Login.WarningDismisser();

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
