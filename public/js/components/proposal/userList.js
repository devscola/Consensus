Class('Proposal.UserList', {

    Extends: Component,

    initialize: function() {
        Proposal.UserList.Super.call(this, 'user-selection');
        this.proposal = null;
        this.empty();
    },

    show: function() {
        this.element.style.display = 'block';
    },

    hide: function() {
        this.element.style.display = 'none';
    },

    empty: function() {
        this.hide();
        this.proposal = null;
    },

    subscribe: function() {
        Bus.subscribe('proposal.empty', this.empty.bind(this));
        Bus.subscribe('proposal.circle.finished', this.hide.bind(this));
        Bus.subscribe('proposal.added', this.show.bind(this));
    }

});
