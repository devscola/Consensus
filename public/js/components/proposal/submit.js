Class('Proposal.Submit', {

    Extends: Component,

    initialize: function() {
        Proposal.Submit.Super.call(this, 'proposal-submit');
        this.element.addEventListener('click', this.submitProposal.bind(this));
    },

    submitProposal: function() {
        Bus.publish('proposal.submit');
    },

    activate: function() {
        this.element.disabled = false;
    },

    deactivate: function() {
        this.element.disabled = true;
    },

    subscribe: function() {
        Bus.subscribe('proposal.content.ready', this.activate.bind(this));
        Bus.subscribe('proposal.content.not.ready', this.deactivate.bind(this));
    }

});
