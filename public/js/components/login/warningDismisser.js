Class('Login.WarningDismisser', {

    Extends: Component,

    initialize: function() {
        Login.WarningDismisser.Super.call(this, 'dismiss-warning');
        this.element.addEventListener('click', this.press.bind(this));
    },

    press: function() {
        Bus.publish('login.warning.dismiss');
    }

});
