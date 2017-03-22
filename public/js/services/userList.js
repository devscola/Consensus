var UserListService = function() {

    var doRequest = function(endpoint, circleData, callback) {
        var request = new XMLHttpRequest();
        var OK = 200;

        request.open('POST', endpoint);
        request.setRequestHeader('Content-Type', 'application/json');
        request.onreadystatechange = function() {
            if (request.readyState === XMLHttpRequest.DONE) {
                if (request.status === OK) {
                    callback(JSON.parse(request.responseText));
                }
            }
        };
        request.send(JSON.stringify(circleData));
    };

    var list = function() {
        result = JSON.parse('["KingRobert","Cersei","Khaleesi"]');
            Bus.publish('users.retrieved', result);
    };

    var add = function(circleData) {
        doRequest('/proposal/user/add', circleData, function(result){
            Bus.publish('proposal.user.added');
        });
    };

    var retrieve = function(id) {
        doRequest('/proposal/users/retrieve', id, function(result){
            Bus.publish('proposal.circle.retrieved', result.circle);    
        });
    };

    Bus.subscribe('proposal.submit', list);
    Bus.subscribe('user.clicked', list);
    Bus.subscribe('proposal.user.add', add);
    Bus.subscribe('proposal.circle.retrieve', retrieve);
};