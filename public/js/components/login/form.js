Class('Login.Form', {

    Extends: Component,

    initialize: function() {
        Login.Form.Super.call(this, 'login');
        this.element.addEventListener('submit', this.doLogin);
    },

    doLogin: function(data) {
        Bus.publish('LoginAttempt', data.detail);
    },

    showWarning: function() {
        this.element.warningShown = true;
    },

    subscribe: function() {
        Bus.subscribe('attemp.failed', this.showWarning.bind(this));
    }

});
