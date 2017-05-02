Class('DiscussionBoard.ProposalPanel', {

    Extends: Component,

    initialize: function() {
        DiscussionBoard.ProposalPanel.Super.call(this, 'proposal');
    },

    render: function(data) {
        this.element.title = data.title;
        this.element.content = data.content;
        this.element.circle = data.circle;
    },

    subscribe: function() {
        Bus.subscribe('proposal.retrieved', this.render.bind(this));
    }

});
