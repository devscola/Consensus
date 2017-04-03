Class('Login.Form', {

    Extends: Component,

    initialize: function() {
        Login.Form.Super.call(this, 'login-form');
        new Login.Submit();
        new Login.Username();
        new Login.Password();
        new Login.PasswordToggler();
    },

    doLogin: function() {
        var credentials = this.retrieveCredentials();

        Bus.publish('LoginAttempt', credentials);
    },

    retrieveCredentials: function() {
        return {username: this.username, password: this.password};
    },

    captureUsername: function(value) {
        this.username = value;
    },

    capturePassword: function(value) {
        this.password = value;
    },

    subscribe: function() {
        Bus.subscribe('login.submit.clicked', this.doLogin.bind(this));
        Bus.subscribe('login.username.sent', this.captureUsername.bind(this));
        Bus.subscribe('login.password.sent', this.capturePassword.bind(this));
    }

});
