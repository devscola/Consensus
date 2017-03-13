var CreateProposalButton = function() {
    var createProposalButton = document.getElementById('create-proposal');

    var createProposal = function() {
        Bus.publish('proposal.new');
    };
    createProposalButton.addEventListener('click', createProposal);
};
