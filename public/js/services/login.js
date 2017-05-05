Class('Services.Login', {

    Extends: Service,

    initialize: function() {
        Services.Login.Super.call(this, '/login');
    },

    hasSucceeded: function(result) {
        if (result.valid) {
            Bus.publish('login.attempt.succeeded', result);
        } else {
            Bus.publish('login.attempt.failed');
        }
    },

    login: function(credentials) {
        this.doRequest('', credentials, this.hasSucceeded);
    },

    subscribe: function() {
        Bus.subscribe('login.attempt', this.login.bind(this));
    }

});
