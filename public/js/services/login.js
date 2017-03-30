Class('Services.Login', {

    Extends: Service,

    initialize: function() {
        Services.Login.Super.call(this, '/login');
        Bus.subscribe('LoginAttempt', this.login.bind(this));
    },

    hasSucceeded: function(result) {
        return result.valid;
    },

    login: function(credentials) {
        callback = function(result) {
            Bus.publish('login.result', this.hasSucceeded(result));
        };

        this.doRequest(this.baseUrl, credentials, callback.bind(this));
    }

});
