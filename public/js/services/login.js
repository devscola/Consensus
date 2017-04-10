Class('Services.Login', {

    Extends: Service,

    initialize: function() {
        Services.Login.Super.call(this, '/login');
    },

    hasSucceeded: function(result) {
        if (result.token) {
            Bus.publish('attemp.succeeded');
        } else {
            Bus.publish('attemp.failed');
        }
    },

    login: function(credentials) {
        this.doRequest(this.baseUrl, credentials, this.hasSucceeded);
    },

    subscribe: function() {
        Bus.subscribe('LoginAttempt', this.login.bind(this));
    }

});
