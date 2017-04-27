Class('Page.Proposals', {

    Extends: Page,

    initialize: function() {
        instances = [
            Services.Proposals,
            Proposals.ProposalCreator,
            Proposals.List,
            Proposals.Form,
            Services.UserList,
            Services.Storage
        ];
        Page.Proposals.Super.call(this, instances);
    },

    publish: function() {
        Bus.publish('proposal.list');
    },

    subscribe: function() {}

});
