Class('Page.Login', {

    Extends: Page,

    STATIC: {
        HOME: '/'
    },

    initialize: function() {
        instances = [Login.Form, Login.Warning, Login.WarningDismisser, Services.Login];
        Page.Login.Super.call(this, instances);
    },

    goToHome: function() {
        window.location = Page.Login.HOME;
    },

    doLogin: function() {
        this.goToHome();
    },

    checkLogin: function(result) {
        if (!result) {
            Bus.publish('warning.show');
            return;
        }
        this.doLogin();
    },

    publish: function() {},

    subscribe: function() {
        Bus.subscribe('login.result', this.checkLogin.bind(this));
    }

});
