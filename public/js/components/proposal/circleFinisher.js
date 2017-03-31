Class('Proposal.CircleFinisher', {

    Extends: Component,

    initialize: function() {
        Proposal.CircleFinisher.Super.call(this, 'proposal-finish');
        this.element.addEventListener('click', this.press.bind(this));
    },

    press: function() {
        Bus.publish('proposal.circle.finished');
    },

    show: function() {
        this.element.style.display = 'block';
    },

    hide: function() {
        this.element.style.display = 'none';
        this._disable();
    },

    enable: function() {
        this.element.disabled = false;
    },

    _disable: function() {
        this.element.disabled = true;
    },

    subscribe: function() {
        Bus.subscribe('proposal.submit', this.show.bind(this));
        Bus.subscribe('proposal.new', this.hide.bind(this));
        Bus.subscribe('proposal.user.added', this.enable.bind(this));
    }
});
