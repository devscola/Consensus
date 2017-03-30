var LoginPage = function() {
    new Services.Login();
    new Form();
    new Warning();

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
