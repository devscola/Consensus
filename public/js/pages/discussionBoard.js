Class('Page.DiscussionBoard', {

    Extends: Page,

    initialize: function() {
        instances = [DiscussionBoard.Title, DiscussionBoard.Content, DiscussionBoard.Circle, Services.Proposals];
        Page.DiscussionBoard.Super.call(this, instances);
    },

    retrieveId: function() {
        var url = window.location.href;
        return url.split('discussion-board/')[1];
    },

    publish: function() {
        id = this.retrieveId();
        Bus.publish('proposal.retrieve', id);
    },

    request_for_inside_user_circle: function(username) {
        id = this.retrieveId();
        validUserName = Services.Proposals.retrieve_valid_user_for_circle(id, username);
        return validUserName;
    },

    subscribe: function() {}

});
