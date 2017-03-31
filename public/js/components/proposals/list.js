Class('Proposals.List', {

    Extends: Component,

    initialize: function() {
        console.log('initialize Proposals.List');
        Proposals.List.Super.call(this, 'proposals-list');
    },

    show: function(proposals) {
        this._emptyList();
        this._enlist(proposals);
    },

    retrieve: function() {
        Bus.publish('proposal.list');
    },

    _emptyList: function() {
        this.element.innerHTML = '';
    },

    _enlist: function(proposals) {
        var callback = function(proposal) {
            var entry = this._createEntry();
            var link = this._linkerize(proposal);

            link.textContent = proposal.title;
            entry.append(link);
            this.element.append(entry);
        };
        proposals.result.forEach(callback.bind(this));
    },

    _createEntry: function() {
        var container = document.createElement('div');
        container.className = 'proposal-entry list-group-item';
        return container;
    },

    _linkerize: function(proposal){
        var link = document.createElement('a');
        link.href = 'discussion-board/' + proposal.id;
        return link;
    },


    subscribe: function() {
        Bus.subscribe('proposal.listed', this.show.bind(this));
        Bus.subscribe('proposal.added', this.retrieve.bind(this));
    }
});
