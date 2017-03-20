var CreateProposal = function() {
    var createProposal = document.getElementById('create-proposal');

    var newProposal = function() {
        Bus.publish('proposal.new');
    };
    createProposal.addEventListener('click', newProposal);
};
