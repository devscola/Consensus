Class('Proposals.ProposalCreator', {

    Extends: Component,

    initialize: function() {
        Proposals.ProposalCreator.Super.call(this, 'create-proposal');
        this.element.addEventListener('create', this.create.bind(this));
        this.isLogged();
    },

    showButton: function() {
       this.element.actionAllowed = true;
    },

    enableButton: function() {
        this.element.activated = true;
    },

    create: function() {
        this.element.activated = false;
        Bus.publish('proposal.new');
    },

    isLogged: function(){
        Bus.publish('proposal.check.user.logged');
    },

    subscribe: function() {
        Bus.subscribe('proposal.create.button.show', this.showButton.bind(this));
        Bus.subscribe('proposal.circle.finished', this.enableButton.bind(this));
    }

});
