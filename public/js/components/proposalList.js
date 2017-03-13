var ProposalList = function() {
    var proposalList = document.getElementById('proposal-list');

    var showList = function(list){
        proposalList.innerHTML="";
        list.result.forEach(function(proposal){
            var element= document.createElement('div');
            element.className='proposal-entry';
            element.innerHTML = proposal.title;
            proposalList.append(element);
        });
    }

    var retrieveList = function(){
        Bus.publish('proposal.list');
    }
    Bus.subscribe('proposal.listed', showList);
    Bus.subscribe('proposal.added', retrieveList);
};
