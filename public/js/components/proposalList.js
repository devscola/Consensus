var ProposalList = function() {
    var proposalList = document.getElementById('proposal-list');

    var showList = function(list){
        proposalList.innerHTML="";
        list.result.forEach(function(proposal){
            var element= document.createElement('div');
            element.className='proposal-entry';
            var link = document.createElement('a');
            link.href=  'discussion-board/' + proposal.id;

            link.innerHTML = proposal.title;
            element.append(link);
            proposalList.append(element);
        });
    };

    var retrieveList = function(){
        Bus.publish('proposal.list');
    };

    Bus.subscribe('proposal.listed', showList);
    Bus.subscribe('proposal.added', retrieveList);
};
