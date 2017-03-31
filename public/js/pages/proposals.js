var ProposalsPage = function() {
    new Proposals.ProposalCreator();
    new Proposals.List();
    new Proposals.Form();
    new Services.UserList();
    new Services.Proposals();

    Bus.publish('proposal.list');
};
