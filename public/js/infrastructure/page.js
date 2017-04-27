Class('Page', {

    initialize: function(components) {
        this.initializeComponents(components);
        this.initializeServices();
        this.initializeCommonServices();
        this.publish();
        this.subscribe();
    },

    initializeComponents: function (components) {
        components.forEach(function(componentName) {
            new componentName();
        }); 
    },

    initializeServices: function () {

    },

    initializeCommonServices: function () {

    },

    publish: function() {
        console.error(this.toString() + ' not publishing!, implement publish method');
    },

    subscribe: function() {
        console.error(this.toString() + ' not subscribed!, implement subscribe method');
    }

});
