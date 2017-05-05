Class('Login.Form', {

    Extends: Component,

    initialize: function() {
        Login.Form.Super.call(this, 'login');
        this.element.addEventListener('submit', this.doLogin);
    },

    doLogin: function(polymerEvent) {
        Bus.publish('login.attempt', polymerEvent.detail);
    },

    showWarning: function() {
        this.element.warningShown = true;
    },

    subscribe: function() {
        Bus.subscribe('login.attempt.failed', this.showWarning.bind(this));
    }

});
