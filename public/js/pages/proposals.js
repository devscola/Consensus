var ProposalsPage = function() {
    new CreateProposal();
    new List();
    new Form();
    new UserList();
    new Services.UserList();
    new Services.Proposals();

    Bus.publish('proposal.list');
};
