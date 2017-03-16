var ProposalsService = function() {

    var add = function(proposalData) {
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

    var list = function (){
        doRequest('/proposals/list', '', function(result) {
            Bus.publish('proposal.listed', result);
        });
    };

    var retrieve = function (){
        result={'title': 'an_expected_title',
                'content': 'some pretty content'}
        Bus.publish('proposal.retrieved', result);
    };

    Bus.subscribe('proposal.add', add);
    Bus.subscribe('proposal.list', list);
    Bus.subscribe('proposal.retrieve', retrieve);

};
