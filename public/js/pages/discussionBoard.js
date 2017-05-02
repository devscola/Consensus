Class('Page.DiscussionBoard', {

    initialize: function() {
        new DiscussionBoard.Title();
        new DiscussionBoard.Content();
        new DiscussionBoard.Circle();
        new DiscussionBoard.Questioner(this.retrieveId());

        new Services.Proposals();
        new Services.DiscussionBoard();
        new Services.Storage();
        this.publish();
    },

    retrieveId: function() {
        var url = window.location.href;
        return url.split('discussion-board/')[1];
    },

    publish: function() {
        id = this.retrieveId();
        Bus.publish('proposal.retrieve', id);
    },
});
