Class('Services.Login', {

    Extends: Service,

    initialize: function() {
        Services.Login.Super.call(this, '/login');
    },

    hasSucceeded: function(result) {
        if (result.valid) {
            localStorage.setItem('authorized', result.token);
            localStorage.setItem('username', result.username);
            Bus.publish('attemp.succeeded');
        } else {
            localStorage.removeItem('authorized');
            Bus.publish('attemp.failed');
        }
    },

    login: function(credentials) {
        this.doRequest('', credentials, this.hasSucceeded);
    },

    subscribe: function() {
        Bus.subscribe('LoginAttempt', this.login.bind(this));
    }

});
