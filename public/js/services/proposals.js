Class('Services.Proposals', {

    Extends: Service,

    initialize: function() {
        this.proposalData = {};
        Services.Proposals.Super.call(this, '/proposals');
    },

    add: function(proposal) {
        this.doRequest('/add', proposal, function(result) {
            Bus.publish('proposal.added', result);
        });
    },

    fillProposalData: function(proposal) {
        proposal.title = this.proposalData.title;
        proposal.content = this.proposalData.content;
        this.add(proposal);
    },

    list: function() {
        this.doRequest('/list', '', function(result) {
            Bus.publish('proposal.listed', result);
        });
    },

    retrieve: function(id) {
        data = {'proposal_id': id};
        this.doRequest('/retrieve', data, function(result) {
            Bus.publish('proposal.retrieved', result);
        });
    },

    holdProposalData: function(proposalData) {
        this.proposalData = proposalData;
        Bus.publish('storage.authorization.retrieve');
    },

    subscribe: function() {
        Bus.subscribe('proposal.add', this.holdProposalData.bind(this));
        Bus.subscribe('proposal.adding', this.fillProposalData.bind(this));
        Bus.subscribe('proposal.list', this.list.bind(this));
        Bus.subscribe('proposal.retrieve', this.retrieve.bind(this));
    }

});
