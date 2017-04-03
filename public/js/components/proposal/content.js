Class('Proposal.Content', {

    Extends: Component,

    STATIC: {
        MIN_PROPOSAL_CONTENT: 1000
    },

    initialize: function() {
        Proposal.Content.Super.call(this, 'proposal-content');
        this.element.addEventListener('input', this.updateCounter.bind(this));
        this.ContentState = 'MIN';
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
            this.ContentState = 'MAX';
            this.element.addEventListener('keyup', this.keySubmit);
            Bus.publish('proposal.content.ready', this.element.value);
        }

        if (this.characterCount() < Proposal.Content.MIN_PROPOSAL_CONTENT) {
            if (this.ContentState == 'MAX') {
                Bus.publish('proposal.content.not.ready');
                this.ContentState = 'MIN';
            }
        }
    },

    subscribe: function() {
        Bus.subscribe('proposal.content.empty', this.empty.bind(this));
    }

});
