Class('Page.Proposals', {

    Extends: Page,

    initialize: function() {
        instances = [
            Services.Proposals,
            Proposals.ProposalCreator,
            Proposals.List,
            Proposals.Form,
            Proposals.Circle,
            Services.UserList
        ];
        Page.Proposals.Super.call(this, instances);
    },

    publish: function() {
        Bus.publish('proposal.list');
    },

    subscribe: function() {}

});
