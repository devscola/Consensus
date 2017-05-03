Class('Proposals.List', {

    Extends: Component,

    initialize: function() {
        Proposals.List.Super.call(this, 'proposals-list');
    },

    show: function(proposals) {
        this.element.innerHTML = '';
        this.enlist(proposals);
    },

    retrieve: function() {
        Bus.publish('proposal.list');
    },

    enlist: function(proposals) {
        var callback = function(proposal) {
            var entry = this.createEntry();
            var link = this.linkerize(proposal);

            link.textContent = proposal.title;
            entry.append(link);
            this.element.append(entry);
        };
        proposals.result.forEach(callback.bind(this));
    },

    createEntry: function() {
        var container = document.createElement('div');
        container.className = 'proposal-entry list-group-item';
        return container;
    },

    linkerize: function(proposal){
        var link = document.createElement('a');
        link.href = 'discussion-board/' + proposal.id;
        return link;
    },


    subscribe: function() {
        Bus.subscribe('proposal.listed', this.show.bind(this));
        Bus.subscribe('proposal.added', this.retrieve.bind(this));
    }

});
