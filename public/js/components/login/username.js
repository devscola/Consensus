Class('Login.Username', {

    Extends: Component,

    initialize: function() {
        Login.Username.Super.call(this, 'username');
        this.element.addEventListener('blur', this.send.bind(this));
    },

    send: function() {
        Bus.publish('login.username.sent', this.element.value);
    }

});