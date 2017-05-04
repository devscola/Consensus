Class('Proposals.List', {

    Extends: Component,

    initialize: function() {
        Proposals.List.Super.call(this, 'proposals-list');
        this.proposalsContainer = document.getElementById('proposals-container');
    },

    render: function(proposals) {
        var proposalsList = [];
        proposals.result.forEach(function(proposal) {
            proposalsList.push({
                title: proposal.title,
                id: proposal.id
            });
        });
        this.proposalsContainer.proposalsList = proposalsList;        
    },

    retrieve: function() {
        Bus.publish('proposal.list');
    },

    subscribe: function() {
        Bus.subscribe('proposal.listed', this.render.bind(this));
        Bus.subscribe('proposal.added', this.retrieve.bind(this));
    }

});
