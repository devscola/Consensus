Class('Login.Warning', {

    Extends: Component,

    initialize: function() {
        Login.Warning.Super.call(this, 'warning');
        this._doHide();
    },

    show: function() {
        this.element.style.display = 'block';
    },

    hide: function() {
        this._doHide();
        Bus.publish('dismissed');
    },

    _doHide: function() {
        this.element.style.display = 'none';
    },

    subscribe: function() {
        Bus.subscribe('warning.show', this.show.bind(this));
        Bus.subscribe('warning.hide', this.hide.bind(this));
        Bus.subscribe('login.warning.dismiss', this.hide.bind(this));
    }

});
