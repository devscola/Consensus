Class('Page.Login', {

    Extends: Page,

    STATIC: {
        HOME: '/'
    },

    initialize: function() {
        instances = [Login.Form, Services.Login];
        Page.Login.Super.call(this, instances);
        new Services.Storage();
    },

    goToHome: function() {
        window.location = Page.Login.HOME;
    },

    publish: function() {},

    subscribe: function() {
        Bus.subscribe('attemp.succeeded', this.goToHome);
    }

});
