Class('Services.Storage', {

    Extends: Service,

    initialize: function() {
        Services.Storage.Super.call(this, '');
    },

    storageAuthorization: function (result) {
        localStorage.setItem('authorized', result.token);
        localStorage.setItem('username', result.username);
    },

    removeAuthorization: function () {
        localStorage.removeItem('authorized');
    },

    retrieveUsername: function () {
        var username = localStorage.getItem('username');
        Bus.publish('storage.username.retrieved', username);
    },

    retrieveAuthorization: function () {
        var authorized = localStorage.getItem('authorized');
        Bus.publish('storage.authorization.retrieved', authorized);
    },

    subscribe: function() {
        Bus.subscribe('login.attempt.succeeded', this.storageAuthorization.bind(this));
        Bus.subscribe('login.attempt.failed', this.removeAuthorization.bind(this));
        Bus.subscribe('storage.username.retrieve', this.retrieveUsername.bind(this));
        Bus.subscribe('storage.authorization.retrieve', this.retrieveAuthorization.bind(this));
    }

});
