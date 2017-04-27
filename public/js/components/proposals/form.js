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

    showCircle: function() {
        this.circleContainer.visible = true;
    },

    refreshCircle: function(proposal) {
        this.circleContainer.proposal = proposal;
    },

    addUserToCircle: function(data){
        Bus.publish('proposal.user.add', data.detail);
    },

    addProposal: function(data) {
        Bus.publish('proposal.add', data.detail);
    },

    fillUsersList: function(list) {
        this.circleContainer.usersList = list;
        this.circleContainer.proposal = this.proposal;
    },

    fillProposal: function(proposal) {
        this.showCircle();
        this.proposal = proposal;
        Bus.publish('users.retrieve');
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
