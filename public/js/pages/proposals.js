var ProposalsPage = function() {
    new CreateProposal();
    new List();
    new Form();
    new ProposalsService();

    Bus.publish('proposal.list');
};
