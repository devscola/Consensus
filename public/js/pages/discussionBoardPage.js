var DiscussionBoardPage = function() {

    var retrieveId = function() {
        var url = window.location.href;
        return url.split('discussion-board/')[1];
    };

    id = retrieveId();
    new Proposal(id);
};
