Class('Login.Submit', {

    Extends: Component,

    initialize: function() {
        Login.Submit.Super.call(this, 'submit');
        this.element.addEventListener('click', this.notifyClick.bind(this));
    },

    notifyClick: function() {
        Bus.publish('login.submit.clicked');
    },

    subscribe: function() {}

});
