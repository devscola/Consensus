var ProposalList = function() {
    var proposalList = document.getElementById('proposal-list');

    var add = function(title) {
        var element = document.createElement('div');
        element.className = 'proposal-entry';
        element.innerHTML = title;
        proposalList.append(element);
    };

    var showList = function(list){
        list.forEach(function(proposal){
            this.add(proposal.title);
        });
    }

    Bus.subscribe('proposal ready', add);
    Bus.subscribe('proposal.listed', showList);
};
