var ProposalsPage = function() {
    new CreateProposal();
    new List();
    new Form();
    new ProposalsService();
    new UserList();
    new Finish_Circle();
    new mockButtonAddUser();

    Bus.publish('proposal.list');
};
