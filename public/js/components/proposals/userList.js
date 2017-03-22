var UserList = function() {
    var list = document.getElementById('user-selection');
    var proposal = null;

    var show = function() {
        Bus.publish('circle.users');
        list.style.visibility = 'visible';
    };

    var start = function(data) {
        proposal = data;
        show();
    }

    var hide = function() {
        list.style.visibility = 'hidden';
    };

    hide();

 
    var displayUsers = function(users) {
        var ulList = document.createElement('ul');
        ulList.className = 'circle-list';
        users.forEach(function(user) {
            var element = document.createElement('li');
            element.textContent = user;
            ulList.append(element);

        });
        list.append(ulList);
    };

    var users = function() {
        doRequest('/proposal/circle', function(users) {
            Bus.publish('display.users', users);
        });
    };

    var doRequest = function(endpoint, callback) {
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
        request.send();
    };

    Bus.subscribe('display.users', displayUsers);
    Bus.subscribe('circle.users', users);
    Bus.subscribe('proposal.added', start);
};
