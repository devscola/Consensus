var ProposalsPage = function() {
    new CreateProposalButton();
    new ProposalList();
    new ProposalForm();
    new ProposalsService();

    Bus.publish('proposal.list');
};
