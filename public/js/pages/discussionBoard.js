Class('Page.DiscussionBoard', {

    Extends: Page,

    initialize: function() {
        instances = [DiscussionBoard.Title, DiscussionBoard.Content, DiscussionBoard.Circle, Services.Proposals];
        Page.DiscussionBoard.Super.call(this, instances);

        new DiscussionBoard.Questioner(this.retrieveId());
    },

    retrieveId: function() {
        var url = window.location.href;
        return url.split('discussion-board/')[1];
    },

    publish: function() {
        id = this.retrieveId();
        Bus.publish('proposal.retrieve', id);
    },

    subscribe: function() {}

});
