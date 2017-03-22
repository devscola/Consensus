var ProposalsPage = function() {
    new CreateProposal();
    new List();
    new Form();
    new ProposalsService();
    new UserList();
    new UserListService();

    Bus.publish('proposal.list');
};
