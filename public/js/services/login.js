Class('Services.Login', {

    Extends: Service,

    initialize: function() {
        Services.Login.Super.call(this, '/login');
    },

    hasSucceeded: function(result) {
        if (result.valid) {
            Bus.publish('attemp.succeeded', result);
        } else {
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
