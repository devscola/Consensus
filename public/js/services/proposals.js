Class('Services.Proposals', {

    Extends: Service,

    initialize: function() {
        Services.Proposals.Super.call(this, '/proposals');
    },

    add: function(proposalData) {
        this.doRequest(this.baseUrl + '/add', proposalData, function(result) {
            Bus.publish('proposal.added', result);
        });
    },

    list: function() {
        this.doRequest(this.baseUrl + '/list', '', function(result) {
            Bus.publish('proposal.listed', result);
        });
    },

    retrieve: function(id) {
        data = {'proposal_id': id};
        this.doRequest(this.baseUrl + '/retrieve', data, function(result) {
            Bus.publish('proposal.retrieved', result);
        });
    },

    retrieve_valid_user_for_circle: function(idProposal, username) {
        data = {'proposal_id': idProposal, 'username' : username};
        this.doRequest(this.baseUrl + '/retrieveValidUserCircle', data, function(result) {
            //Bus.publish('proposal.validUserCircleReceived', result);
        });  
    },

    subscribe: function() {
        Bus.subscribe('proposal.add', this.add.bind(this));
        Bus.subscribe('proposal.list', this.list.bind(this));
        Bus.subscribe('proposal.retrieve', this.retrieve.bind(this));
    }

});
