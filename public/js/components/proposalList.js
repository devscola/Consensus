var ProposalList = function() {
    var proposalList = document.getElementById('proposal-list');

    var showList = function(list){
        proposalList.innerHTML="";
        var accumulator = 0;
        list.result.forEach(function(proposal){
            var element= document.createElement('a');
            element.className='proposal-entry';
            element.href='discussion-board/some-random-title';
            element.innerHTML = accumulator + " " + proposal.title;
            accumulator++;
            proposalList.append(element);
        });
    }

    var retrieveList = function(){
        Bus.publish('proposal.list');
    }
    Bus.subscribe('proposal.listed', showList);
    Bus.subscribe('proposal.added', retrieveList);
};
