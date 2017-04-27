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
        Bus.publish('proposal.logged');
    },

    subscribe: function() {
        Bus.subscribe('proposal.create.show', this.showButton.bind(this));
        Bus.subscribe('circle.finished', this.enableButton.bind(this));
    }

});
