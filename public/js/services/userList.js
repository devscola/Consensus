var UserListService = function() {

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

    var list = function() {
        result = JSON.parse('["KingRobert","Cersei","Khaleesi"]');
            Bus.publish('users.retrieved', result);
    };

    Bus.subscribe('proposal.submit', list);
    Bus.subscribe('user.clicked', list);


};