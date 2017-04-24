Class('Proposals.Circle', {

    Extends: Component,

    initialize: function() {
        Proposals.Form.Super.call(this, 'circle');
        new Proposal.UserList();
        new Proposal.Users();
        new Proposal.CircleFinisher();
    },

    subscribe: function() {}

});
