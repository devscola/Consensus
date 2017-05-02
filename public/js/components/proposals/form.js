Class('Proposals.Form', {

    Extends: Component,

    initialize: function() {
        Proposals.Form.Super.call(this, 'form-container');
        this.element.addEventListener('proposalSubmit', this.addProposal.bind(this));
        this.circleContainer = document.getElementById('circle-container');
        this.circleContainer.addEventListener('proposalUserAdd', this.addUserToCircle.bind(this));
        this.circleContainer.addEventListener('circleFinished', this.finishCircle.bind(this));
    },

    showForm: function() {
        this.circleContainer.visible = false;
        this.element.visible = true;
    },

    addProposal: function(data) {
        Bus.publish('proposal.add', data.detail);
    },

    fillProposal: function(proposal) {
        this.showCircle();
        this.proposal = proposal;
        this.circleContainer.proposal = proposal;
        Bus.publish('users.retrieve');
    },

    showCircle: function() {
        this.circleContainer.visible = true;
    },

    addUserToCircle: function(data){
        Bus.publish('proposal.user.add', data.detail);
    },

    fillUsersList: function(list) {
        this.usersList = list;
        this.refreshCircle(this.proposal);
    },

    refreshCircle: function(proposal) {
        var circleUsersList = [];
        this.usersList.forEach(function(username) {
            circleUsersList.push({
                username: username,
                checked: proposal.circle.includes(username)
            });
        });
        this.circleContainer.circleUsersList = circleUsersList;
    },

    finishCircle: function() {
        Bus.publish('circle.finished');
    },

    subscribe: function() {
        Bus.subscribe('proposal.new', this.showForm.bind(this));
        Bus.subscribe('proposal.added', this.fillProposal.bind(this));
        Bus.subscribe('proposal.user.added', this.refreshCircle.bind(this));
        Bus.subscribe('users.retrieved', this.fillUsersList.bind(this));
    }

});
