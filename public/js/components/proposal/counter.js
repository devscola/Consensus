Class('Proposal.Counter', {

    Extends: Component,

    initialize: function() {
        Proposal.Counter.Super.call(this, 'counter');
    },

    update: function(characterAmount) {
        this.element.innerHTML = characterAmount;
    },

    empty: function() {
        this.element.innerHTML = 0;
    },

    subscribe: function() {
        Bus.subscribe('proposal.update.counter', this.update.bind(this));
        Bus.subscribe('proposal.counter.empty', this.empty.bind(this));
    }

});
