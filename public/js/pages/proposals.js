Class('Page.Proposals', {

    initialize: function() {
        new Services.Proposals();

        new Proposals.ProposalCreator();
        new Proposals.List();
        new Proposals.Form();

        new Services.UserList();
        new Services.Storage();
        this.publish();
    },

    publish: function() {
        Bus.publish('proposal.list');
    }
});
