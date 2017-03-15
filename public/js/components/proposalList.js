var ProposalList = function() {
    var proposalList = document.getElementById('proposal-list');

    var showList = function(list){
        proposalList.innerHTML="";
        list.result.forEach(function(proposal){
            var element= document.createElement('a');
            element.className='proposal-entry';
            href='discussion-board/' + proposal.id;
            element.innerHTML = '<div><a href="' + href + '">' + proposal.title + '</a></div>';
            proposalList.append(element);
        });
    };

    var retrieveList = function(){
        Bus.publish('proposal.list');
    };

    Bus.subscribe('proposal.listed', showList);
    Bus.subscribe('proposal.added', retrieveList);
};
