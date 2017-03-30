Class('Proposal.Title', {

    Extends: Component,

    initialize: function() {
        Proposal.Title.Super.call(this, 'proposal-title');
        this.element.addEventListener('input', this.publishContent.bind(this));
    },

    publishContent: function() {
        Bus.publish('proposal.title.change', this.element.value);
    },

    empty: function() {
        this.element.value = '';
        Bus.publish('proposal.title.change', '');
    },

    subscribe: function() {
        Bus.subscribe('proposal.title.empty', this.empty.bind(this));
    }

});
