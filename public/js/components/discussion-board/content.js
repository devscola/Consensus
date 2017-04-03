Class('DiscussionBoard.Content', {

    Extends: Component,

    initialize: function() {
        DiscussionBoard.Content.Super.call(this, 'content');
    },

    render: function(data) {
        this.element.innerHTML = data.content;
    },

    subscribe: function() {
        Bus.subscribe('proposal.retrieved', this.render.bind(this));
    }

});
