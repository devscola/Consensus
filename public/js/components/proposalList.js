var ProposalList = function() {
    var proposalList = document.getElementById('proposal-list');

    var add = function(title) {
        var element = document.createElement('div');
        element.className = 'proposal-entry';
        element.innerHTML = title;
        proposalList.append(element);
    };

    Bus.subscribe('proposal ready', add);
};
