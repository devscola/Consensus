var ProposalTitle = function() {
    var proposalTitle = document.getElementById('proposal-title');

    var publishContent = function () {
        Bus.publish('proposal.title.change', proposalTitle.value);
    };

    proposalTitle.addEventListener('input', publishContent);

};
