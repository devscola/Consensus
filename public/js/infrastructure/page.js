Class('Page', {

    initialize: function(components) {
        this.initializeComponents(components);
        this.publish();
        this.subscribe();
    },

    initializeComponents: function (components) {
        components.forEach(function(componentName) {
            new componentName();
        }); 
    },

    publish: function() {
        console.error(this.toString() + ' not publishing!, implement publish method');
    },

    subscribe: function() {
        console.error(this.toString() + ' not subscribed!, implement subscribe method');
    }

});
