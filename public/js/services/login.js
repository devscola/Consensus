var LoginService = function() {

    var baseUrl = '/login';

    var hasSucceeded = function(result) {
        return result.valid;
    };

    var login = function(credentials) {
        doRequest(baseUrl, credentials, function(result) {
            var evaluated = hasSucceeded(result);
            Bus.publish('login.result', evaluated);
        });
    };

    var doRequest = function(endpoint, credentials, callback) {
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
        request.send(JSON.stringify(credentials));
    };

    Bus.subscribe('LoginAttempt', login);

};

