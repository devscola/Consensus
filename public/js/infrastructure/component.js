Class('Component', {

    initialize: function(elementId) {
        this.element = document.getElementById(elementId);
        this.subscribe();
    },

    subscribe: function() {
        console.error('Not subscribed!, implement subscribe method');
    }

});
