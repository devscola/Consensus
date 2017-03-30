var ProposalsPage = function() {
    new CreateProposal();
    new List();
    new Form();
    new UserList();
    new UserListService();
    new Services.Proposals();

    Bus.publish('proposal.list');
};
