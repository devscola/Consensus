Class('Services.Proposals', {

    Extends: Service,

    initialize: function() {
        this.proposalData = {};
        Services.Proposals.Super.call(this, '/proposals');
    },

    add: function(proposalData) {
        this.doRequest('/add', proposalData, function(result) {
            Bus.publish('proposal.added', result);
        });
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
        Bus.publish('storage.retrieve.authorization');
    },

    retrieveProposerName: function (authorized) {
        var oldBaseUrl = this.baseUrl;
        serialized_token = {'token': authorized};

        this.baseUrl = '';
        this.doRequest('/user/logged', serialized_token, function(proposer) {
            this.proposalData.proposer = proposer.username;
            this.add(this.proposalData);
        }.bind(this));
        this.baseUrl = oldBaseUrl;
    },

    retrieveLoggedUser: function() {
        var token = localStorage.getItem('authorized');
        var oldBaseUrl = this.baseUrl;
        serialized_token = {'token': token};
        this.baseUrl = oldBaseUrl;
    },

    retrieveToken: function() {
        var token = localStorage.getItem('authorized');
        var oldBaseUrl = this.baseUrl;
        serialized_token = {'token': token};

        this.baseUrl = '';
        this.doRequest('/create-proposal/token', serialized_token, function(response) {
            if(token == response.token){
                Bus.publish('proposal.create.show');
            }
        }.bind(this));
        this.baseUrl = oldBaseUrl;
    },

    subscribe: function() {
        Bus.subscribe('proposal.logged.user',this.retrieveLoggedUser.bind(this));
        Bus.subscribe('proposal.add', this.holdProposalData.bind(this));
        Bus.subscribe('proposal.logged', this.retrieveToken.bind(this));
        Bus.subscribe('proposal.list', this.list.bind(this));
        Bus.subscribe('proposal.retrieve', this.retrieve.bind(this));
        Bus.subscribe('storage.authorization.retrieved', this.retrieveProposerName.bind(this));
    }

});
