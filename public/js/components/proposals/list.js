var List = function() {
    var proposalList = document.getElementById('proposal-list');

    var showList = function(list) {
        proposalList.innerHTML = '';
        list.result.forEach(function(proposal) {
            var container = ProposalsContainer();
            var link = linkToProposal(proposal);

            link.textContent = proposal.title;
            container.append(link);
            proposalList.append(container);
        });
    };

    var ProposalsContainer = function(){
        var container = document.createElement('div');
        container.className = 'proposal-entry list-group-item';
        return container;
    };

    var linkToProposal = function(proposal){
        var link = document.createElement('a');
        link.href = 'discussion-board/' + proposal.id;
        return link;
    };

    var retrieveList = function() {
        Bus.publish('proposal.list');
    };

    Bus.subscribe('proposal.listed', showList);
    Bus.subscribe('proposal.added', retrieveList);
};
