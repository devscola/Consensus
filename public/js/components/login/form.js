var Form = function() {
    new Login.Submit();
    new Login.Username();
    new Login.Password();
    new Login.PasswordToggler();
    var username;
    var password;

    var retrieveCredentials = function() {
        return {username: username, password: password};
    };

    var doLogin = function() {
        var credentials = retrieveCredentials();

        Bus.publish('LoginAttempt', credentials);
    };

    var fillUsername = function(value) {
        username = value;
    };

    var fillPassword = function(value) {
        password = value;
    };

    Bus.subscribe('login.submit.clicked', doLogin);
    Bus.subscribe('login.username.sent', fillUsername);
    Bus.subscribe('login.password.sent', fillPassword);
};
