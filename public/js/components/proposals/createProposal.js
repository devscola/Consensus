Class('Proposals.ProposalCreator', {

    Extends: Component,

    initialize: function() {
        Proposals.ProposalCreator.Super.call(this, 'create-proposal');
        this.element.addEventListener('click', this.create.bind(this));
    },

    create: function() {
        Bus.publish('proposal.empty');
        Bus.publish('proposal.new');
    },

    subscribe: function() {}

});
