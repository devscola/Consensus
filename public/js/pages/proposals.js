Class('Page.Proposals', {

    Extends: Page,

    initialize: function() {
        instances = [Proposals.ProposalCreator, Proposals.List, Proposals.Form, Services.UserList, Services.Proposals];
        Page.Proposals.Super.call(this, instances);
    },

    publish: function() {
        Bus.publish('proposal.list');
    },

    subscribe: function() {}

});
