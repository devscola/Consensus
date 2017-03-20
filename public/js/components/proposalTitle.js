var ProposalTitle = function() {
    var proposalTitle = document.getElementById('proposal-title');

    var publishContent = function () {
        Bus.publish('proposal.title.change', proposalTitle.value);
    };

    var emptyTitle = function () {
        proposalTitle.value = '';
        Bus.publish('proposal.title.change', '');
    }

    Bus.subscribe('proposal.title.empty', emptyTitle);

    proposalTitle.addEventListener('input', publishContent);

};