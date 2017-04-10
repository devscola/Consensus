Class('Page.Login', {

    Extends: Page,

    STATIC: {
        HOME: '/'
    },

    initialize: function() {
        instances = [Login.Form, Services.Login];
        Page.Login.Super.call(this, instances);
    },

    goToHome: function() {
        window.location = Page.Login.HOME;
    },

    doLogin: function() {
        this.goToHome();
    },

    publish: function() {},

    subscribe: function() {
        Bus.subscribe('attemp.succeeded', this.goToHome);
    }

});
