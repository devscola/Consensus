Class('Component', {

    initialize: function(elementId) {
        this.element = document.getElementById(elementId);
        this.subscribe();
    },

    subscribe: function() {
        console.error(this.toString() + ' not subscribed!, implement subscribe method');
    }

});
