Class('Login.Password', {

    Extends: Component,

    initialize: function() {
        Login.Username.Super.call(this, 'password');
        this.element.addEventListener('blur', this.send.bind(this));
    },

    showText: function() {
        this.element.type = 'text';
        Bus.publish('login.passwordToggler.change', 'open');
    },

    showPassword:  function() {
        this.element.type = 'password';
        Bus.publish('login.passwordToggler.change', 'close');
    },

    toggleVisibility: function() {
        if (this.element.type === 'password') {
            this.showText();
        } else {
            this.showPassword();
        }
    },

    send: function() {
        Bus.publish('login.password.sent', this.element.value);
    },

    subscribe: function() {
        Bus.subscribe('login.passwordToggler.clicked', this.toggleVisibility.bind(this));
    }

});