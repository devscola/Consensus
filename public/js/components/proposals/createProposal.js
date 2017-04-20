Class('Proposals.ProposalCreator', {

    Extends: Component,

    initialize: function() {
        Proposals.ProposalCreator.Super.call(this, 'create-proposal');
        this.element.addEventListener('create', this.create.bind(this));
        this._isLogged();
    },

    showButton: function() {
       this.element.actionAllowed = true; 
    },

    create: function() {
        Bus.publish('proposal.empty');
        Bus.publish('proposal.new');
    },

    _isLogged: function(){
        Bus.publish('proposal.logged');
    },

    subscribe: function() {
        Bus.subscribe('proposal.create.show', this.showButton.bind(this));
    }

});
