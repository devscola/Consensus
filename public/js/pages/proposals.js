var ProposalsPage = function() {
    new CreateProposal();
    new List();
    new Form();
    new ProposalsService();
    new Circle();

    Bus.publish('proposal.list');
};
