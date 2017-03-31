Class('Login.PasswordToggler', {

    Extends: Component,

    initialize: function() {
        Login.PasswordToggler.Super.call(this, 'password-toggler');
        this.element.addEventListener('click', this.send.bind(this));
    },

    eyeWillBe: function(eyeTypeWanted) {
        this.element.ClassName = 'glyphicon glyphicon-eye-' + eyeTypeWanted;
    }, 

    send: function() {
        Bus.publish('login.passwordToggler.clicked');
    },

    subscribe: function() {
        Bus.subscribe('login.passwordToggler.change', this.eyeWillBe.bind(this));
    }

});