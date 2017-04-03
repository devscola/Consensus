var DiscussionBoardPage = function() {

    var retrieveId = function() {
        var url = window.location.href;
        return url.split('discussion-board/')[1];
    };

    id = retrieveId();

    new DiscussionBoard.Title();
    new DiscussionBoard.Content();
    new DiscussionBoard.Circle();
    new Services.Proposals();

    Bus.publish('proposal.retrieve', id);

};
