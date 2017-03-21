var ProposalsPage = function() {
    new CreateProposal();
    new List();
    new Form();
    new ProposalsService();
    new UserList();

    Bus.publish('proposal.list');
};
