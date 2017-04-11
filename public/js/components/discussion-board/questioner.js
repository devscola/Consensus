Class('DiscussionBoard.Questioner', {

    Extends: Component,

    initialize: function(proposalId) {
        this.proposalId = proposalId;
        DiscussionBoard.Questioner.Super.call(this, 'questioner');
        this.involvedInCircle();
    },

    involvedInCircle: function() {
        var token = localStorage.getItem('authorized');
        var data = {'id': this.proposalId, 'token': token};
        Bus.publish('proposal.validate.user', data);
    },

    userValidation: function(result) {
        if (result.valid) {
            this.showButton();
        }
    },

    showButton: function() {
        this.element.buttonVisibility = true;
    },

    subscribe: function() {
        Bus.subscribe('proposal.user.validated', this.userValidation.bind(this));
    }

});
