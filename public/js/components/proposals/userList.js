var UserList = function() {
    var container = document.getElementById('user-selection');
    var list = document.getElementById('users');

    var proposal,circle;

    var showUsers = function (result) {
        list.innerHTML = '';
        result.forEach(function(username) {
            var element = document.createElement('li');
            element.className = 'user list-group-item';


            selectUser(username, element);

            element.append(document.createTextNode(' ' + username));
            list.append(element);

            //element.textContent = username;
            //list.append(element);

        });
    };

    var selectUser = function(username, element) {
        if (circle.includes(username)) {
            checkSymbol = addCheckSymbol(username);
            element.append(checkSymbol);
        } else {
            button = addButton(username);
            element.append(button);
        }
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
        button = createAddToCircleButton(username);
        addUserEvent(button);
        return button;
    };

    var createAddToCircleButton = function(username) {
        var iconButton = document.createElement('span');
        iconButton.className = 'add-button glyphicon glyphicon-unchecked';
        iconButton.setAttribute('style','cursor: pointer');
        iconButton.id = username;

       return iconButton;
    };

    var addUserEvent = function(button) {
        button.addEventListener('click', function(){
            addUserToCircle(this.id);
            Bus.publish('user.clicked');
        });
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
