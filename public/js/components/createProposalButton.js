var CreateProposalButton = function() {
    var createProposalButton = document.getElementById('create-proposal');

    var createProposal = function() {
        Bus.publish('new proposal');
    };
    createProposalButton.addEventListener('click', createProposal);
};
