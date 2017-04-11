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

    userInCircle: function(data) {
        this.doRequest(this.baseUrl + '/user/involved', data, function(result) {
            Bus.publish('proposal.user.validated', result);
        });
    },

    subscribe: function() {
        Bus.subscribe('proposal.add', this.add.bind(this));
        Bus.subscribe('proposal.list', this.list.bind(this));
        Bus.subscribe('proposal.retrieve', this.retrieve.bind(this));
        Bus.subscribe('proposal.validate.user', this.userInCircle.bind(this));
    }

});
