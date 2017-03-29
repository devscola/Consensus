var LoginPage = function() {
    new LoginService();
    new Form();
    new Warning();

    var HOME = '/';

    var goToHome = function() {
        window.location = HOME;
    };

    var doLogin = function() {
        Bus.publish('warning.hide');
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
