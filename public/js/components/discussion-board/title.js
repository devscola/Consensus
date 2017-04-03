Class('DiscussionBoard.Title', {

    Extends: Component,

    initialize: function() {
        DiscussionBoard.Title.Super.call(this, 'title');
    },

    render: function(data) {
        this.element.innerHTML = data.title;
    },

    subscribe: function() {
        Bus.subscribe('proposal.retrieved', this.render.bind(this));
    }

});
