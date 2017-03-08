var ProposalTitle = function() {
    var proposalTitle = document.getElementById('proposal-title');

    var send = function() {
        var content = proposalTitle.value;
        Bus.publish('proposal ready', content);
    };

    Bus.subscribe('submit proposal', send);
};
