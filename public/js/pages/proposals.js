Class('Page.Proposals', {

    Extends: Page,

    initialize: function() {
        instances = [
            Services.Proposals,
            Proposals.ProposalCreator,
            Proposals.List,
            Proposals.Form,
            Services.UserList
        ];
        Page.Proposals.Super.call(this, instances);
        new Services.Storage();
    },

    publish: function() {
        Bus.publish('proposal.list');
    },

    subscribe: function() {}

});
