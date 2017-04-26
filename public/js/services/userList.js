Class('Services.UserList', {

    Extends: Service,

    initialize: function() {
        Services.UserList.Super.call(this, '/proposal');
    },

    list: function() {
        this.doRequest('/circle', '', function(result) {
            Bus.publish('users.retrieved', result);
        });
    },

    add: function(circleData) {
        this.doRequest('/user/add', circleData, function(result) {
            Bus.publish('proposal.user.added', result);
        });
    },

    retrieve: function(id) {
        this.doRequest('/users/retrieve', id, function(result) {
            Bus.publish('proposal.circle.retrieved', result.circle);
        });
    },

    subscribe: function() {
        Bus.subscribe('users.retrieve', this.list.bind(this));
        Bus.subscribe('proposal.user.add', this.add.bind(this));
        Bus.subscribe('proposal.circle.retrieve', this.retrieve.bind(this));
    }

});
