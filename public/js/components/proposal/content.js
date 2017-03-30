Class('Proposal.Content', {

    Extends: Component,

    STATIC: {
        MIN_PROPOSAL_CONTENT: 1000
    },

    initialize: function() {
        Proposal.Content.Super.call(this, 'proposal-content');
        this.element.addEventListener('input', this.updateCounter.bind(this));
        this.updateCounter();
    },

    empty: function() {
        this.element.value = '';
        Bus.publish('proposal.content.not.ready');
    },

    keySubmit: function(evt) {
        if (evt.ctrlKey && evt.keyCode == 13) {
            Bus.publish('proposal.submit');}
    },

    characterCount: function() {
        return this.element.textLength;
    },

    updateCounter: function() {
        Bus.publish('proposal.update.counter', this.characterCount());

        if (this.characterCount() >= Proposal.Content.MIN_PROPOSAL_CONTENT) {
            Bus.publish('proposal.content.ready', this.element.value);
            this.element.addEventListener('keyup', this.keySubmit);
        }

        if (this.characterCount() < Proposal.Content.MIN_PROPOSAL_CONTENT) {
            Bus.publish('proposal.content.not.ready');
        }
    },

    subscribe: function() {
        Bus.subscribe('proposal.content.empty', this.empty.bind(this));
    }

});
