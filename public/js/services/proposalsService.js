var ProposalsService = function() {

    var addProposal = function(proposalData) {
        doRequest('/proposals/add', proposalData, function() {
            Bus.publish('proposal.added');
        });
    };

    var doRequest = function(endpoint, proposalData, callback) {
        var request = new XMLHttpRequest();
        var OK = 200;

        request.open('POST', endpoint);
        request.setRequestHeader('Content-Type', 'application/json');
        request.onreadystatechange = function() {
            if (request.readyState === XMLHttpRequest.DONE) {
                if (request.status === OK) {
                    callback (JSON.parse(request.responseText));
                }
            }
        };
        request.send(JSON.stringify(proposalData));
    };

    Bus.subscribe('proposal.add', addProposal);

};
