Class('Page.Login', {

    STATIC: {
        HOME: '/'
    },

    initialize: function() {
        new Login.Form();

        new Services.Login();
        new Services.Storage();
        this.subscribe();
    },

    goToHome: function() {
        window.location = Page.Login.HOME;
    },

    subscribe: function() {
        Bus.subscribe('login.attempt.succeeded', this.goToHome);
    }
});
