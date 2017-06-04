Class('Services.Authorization', {

    Extends: Service,

    initialize: function() {
        Services.Authorization.Super.call(this, '');
        this.proposal = {};
    },

    retrieveProposerName: function (authorized) {
        serialized_token = {'token': authorized};

        this.doRequest('/user/logged', serialized_token, function(proposer) {
            this.proposal.proposer = proposer.username;
            Bus.publish('proposal.adding', this.proposal);
        }.bind(this));
    },

    retrieveToken: function() {
        var token = localStorage.getItem('authorized');
        serialized_token = {'token': token};

        this.doRequest('/create-proposal/token', serialized_token, function(response) {
            if(token == response.token) {
                Bus.publish('proposal.create.button.show');
            }
        }.bind(this));
    },

    subscribe: function() {
        Bus.subscribe('proposal.check.user.logged', this.retrieveToken.bind(this));
        Bus.subscribe('storage.authorization.retrieved', this.retrieveProposerName.bind(this));
    }

});
