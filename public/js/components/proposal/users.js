Class('Proposal.Users', {

    Extends: Component,

    initialize: function() {
        Proposal.Users.Super.call(this, 'users');
        this.circle = [];
    },

    show: function (result) {
        this.element.innerHTML = '';
        result.forEach(function(username) {
            var listItem = document.createElement('li');
            listItem.className = 'user list-group-item';

            this.selectUser(username, listItem);

            listItem.append(document.createTextNode(' ' + username));
            this.element.append(listItem);

        }.bind(this));
    },

    start: function(data) {
        this.proposal = data;
    },

    selectUser: function(username, element) {
        if (this.circle.includes(username)) {
            checkSymbol = this.createCheckSymbol(username);
            element.append(checkSymbol);
        } else {
            button = this.createButton(username);
            element.append(button);
        }
    },

    createCheckSymbol: function(username) {
        var checkSymbol = document.createElement('span');
        checkSymbol.className = 'glyphicon glyphicon-check';
        checkSymbol.ariaHidden = 'true';
        checkSymbol.id = username + '-checked';
        return checkSymbol;
    },

    createButton: function(username) {
        button = this.createAddToCircleButton(username);
        this.addUserEvent(button);
        return button;
    },

    createAddToCircleButton: function(username) {
        var iconButton = document.createElement('span');
        iconButton.className = 'glyphicon glyphicon-unchecked';
        iconButton.ariaHidden = 'true';

        var button = document.createElement('button');
        button.appendChild(iconButton);
        button.className = 'add-button';
        button.id = username;

        return button;
    },

    addUserToCircle: function(username) {
        var circleData = {
            username: username,
            id: this.proposal
        };
        Bus.publish('proposal.user.add', circleData);
    },

    retrieveCircle: function(){
        var proposalId = {
            id: this.proposal
        };

        Bus.publish('proposal.circle.retrieve', proposalId);
    },

    addUserEvent: function(button) {
        button.addEventListener('click', function(){
            this.addUserToCircle(button.id);
            Bus.publish('user.clicked');
        }.bind(this));
    },

    fillCircle: function(circleFilled) {
        this.circle = circleFilled;
        Bus.publish('user.clicked');
    },

    subscribe: function() {
        Bus.subscribe('users.retrieved', this.show.bind(this));
        Bus.subscribe('proposal.added', this.start.bind(this));
        Bus.subscribe('proposal.circle.retrieved', this.fillCircle.bind(this));
        Bus.subscribe('proposal.user.added', this.retrieveCircle.bind(this));
    }

});
