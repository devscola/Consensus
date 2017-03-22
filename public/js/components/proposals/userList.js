var UserList = function() {
    var list = document.getElementById('user-selection');
    
    var proposal = null;
    var circle = [];

    var showUsers = function (result) {
        list.innerHTML = '';
        result.forEach(function(username) {
            var element = document.createElement('div');
            element.className = 'user';
            element.innerHTML = username;
            list.append(element); 

            if (circle.includes(username)) {
                checkSymbol = addCheckSymbol(username);
                list.append(checkSymbol); 
            } else {
                button = addButton(username);
                list.append(button); 
            }; 
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
        var button = document.createElement('button');
        var buttonText = document.createTextNode ('Add');
        button.appendChild(buttonText);
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
        checkSymbol.innerHTML = '\u2714';
        checkSymbol.id = username + '-checked'; 
        return checkSymbol;
    };

    var show = function() {
        list.style.visibility = 'visible';
    };

    var start = function(data) {
        proposal = data;
        show();
    };

    var hide = function() {
        list.style.visibility = 'hidden';
    };

    hide();

    Bus.subscribe('proposal.added', start);
    Bus.subscribe('users.retrieved', showUsers);
    Bus.subscribe('proposal.user.added', retrieveCircle);
    Bus.subscribe('proposal.circle.retrieved', fillCircle);
};


