Class('Proposals.Form', {

    Extends: Component,

    initialize: function() {
        Proposals.Form.Super.call(this, 'form-container');
        this.element.addEventListener('proposalSubmit', this.addProposal.bind(this));
    },

    show: function() {
        this.element.visible = true;
    },

    addProposal: function(data) {
        Bus.publish('proposal.add', data.detail);
    },

    subscribe: function() {
        Bus.subscribe('proposal.new', this.show.bind(this));
    }

});
