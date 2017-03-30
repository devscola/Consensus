Class('Proposal.InfoMessage', {

    Extends: Component,

    initialize: function() {
        Proposal.InfoMessage.Super.call(this, 'info-message');
    },

    hide: function() {
        this.element.style.display = 'none';
    },

    show: function() {
        this.element.style.display = 'block';
    },

    subscribe: function() {
        Bus.subscribe('proposal.content.ready', this.hide.bind(this));
        Bus.subscribe('proposal.content.not.ready', this.show.bind(this));
    }

});
