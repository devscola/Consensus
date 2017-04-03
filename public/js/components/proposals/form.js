Class('Proposals.Form', {

    Extends: Component,

    initialize: function() {
        this.proposalData = {};
        Proposals.Form.Super.call(this, 'proposal-form');
        new Proposal.CircleFinisher();
        new Proposal.Title();
        new Proposal.Content();
        new Proposal.Counter();
        new Proposal.Submit();
        new Proposal.InfoMessage();
        new Proposal.UserList();
        new Proposal.Users();
        this.hide();
    },

    hide: function() {
        this.element.style.display = 'none';
    },

    show: function() {
        this.element.style.display = 'block';
    },

    empty: function() {
        Bus.publish('proposal.title.empty');
        Bus.publish('proposal.content.empty');
        Bus.publish('proposal.counter.empty');
    },

    changeTitle: function(title) {
        this.proposalData.title = title;
    },

    changeContent: function(content) {
        this.proposalData.content = content;
    },

    addProposal: function() {
        Bus.publish('proposal.add', this.proposalData);
    },

    subscribe: function() {
        Bus.subscribe('proposal.empty', this.empty.bind(this));
        Bus.subscribe('proposal.new', this.show.bind(this));
        Bus.subscribe('proposal.title.change', this.changeTitle.bind(this));
        Bus.subscribe('proposal.content.ready', this.changeContent.bind(this));
        Bus.subscribe('proposal.submit', this.addProposal.bind(this));
        Bus.subscribe('proposal.added', this.hide.bind(this));
    }
});
