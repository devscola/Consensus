var LoginService = function() {

  var hasSucceeded = function(result) {
    return result.valid;
  };

  var login = function(credentials) {
    doRequest('/login', credentials, function(result) {
      var evaluated = hasSucceeded(result);
      Bus.publish('LoginResult', evaluated);
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

  return {};
};
