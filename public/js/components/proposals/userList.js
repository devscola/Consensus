var UserList = function() {
    var container = document.getElementById('user-selection');
    var list = document.getElementById('users');

    var proposal,circle;

    var showUsers = function (result) {
        list.innerHTML = '';
        result.forEach(function(username) {
            var element = document.createElement('li');
            element.className = 'user list-group-item';
            if (circle.includes(username)) {
                checkSymbol = addCheckSymbol(username);
                element.append(checkSymbol);
            } else {
                button = addButton(username);
                element.append(button);
            }

            element.append(document.createTextNode(' ' + username));
            list.append(element);
        });
    };

    var fillCircle = function(circleFilled){
        circle = circleFilled;
        Bus.publish('user.clicked');

    };

    var addUserToCircle = function(username) {
        var circleData = {
            username: username,
            id: proposal
        };

        Bus.publish('proposal.user.add', circleData);
    };

    var retrieveCircle = function(){
        var proposalId = {
            id: proposal
        };

        Bus.publish('proposal.circle.retrieve', proposalId);
    };

    var addButton = function(username){
        var iconButton = document.createElement('span');
        iconButton.className = 'glyphicon glyphicon-unchecked';
        iconButton.ariaHidden = 'true';
        
        var button = document.createElement('button');
        button.appendChild(iconButton);
        button.className = 'add-button';
        button.id = username;
        button.addEventListener('click', function(){
            addUserToCircle(this.id);
            Bus.publish('user.clicked');
        });
        return button;
    };

    var addCheckSymbol = function(username){
        var checkSymbol = document.createElement('span');
        checkSymbol.className = 'glyphicon glyphicon-check';
        checkSymbol.ariaHidden = 'true';
        checkSymbol.id = username + '-checked';
        return checkSymbol;
    };

    var show = function() {
        container.style.display = 'block';
    };

    var start = function(data) {
        proposal = data;
        show();
    };

    var hide = function() {
        container.style.display = 'none';
    };

    var empty = function() {
        hide();
        proposal = null;
        circle = [];
    };

    empty();

    Bus.subscribe('proposal.added', start);
    Bus.subscribe('users.retrieved', showUsers);
    Bus.subscribe('proposal.user.added', retrieveCircle);
    Bus.subscribe('proposal.circle.retrieved', fillCircle);
    Bus.subscribe('proposal.empty', empty);
    Bus.subscribe('userlist.close', hide);

};
