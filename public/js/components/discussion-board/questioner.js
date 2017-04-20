Class('DiscussionBoard.Questioner', {

    Extends: Component,

    initialize: function(proposalId) {
        this.proposalId = proposalId;
        DiscussionBoard.Questioner.Super.call(this, 'questioner');
        this.element.addEventListener('openTextarea', this._showTextarea.bind(this));
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
        this.element.validQuestioner = true;   
    },

    _showTextarea: function() {
        Bus.publish('discussion-board.show-textarea');
    },

    retrieveId: function() {
        var url = window.location.href;
        return url.split('discussion-board/')[1];
    },

    allowQuestioning: function(proposal) {
        var username = localStorage.getItem('username');
        var involved = proposal.circle.includes(username);
        var isProposer = (proposal.proposer == username);

        this.element.validQuestioner = (involved && !isProposer);
    },

    publish: function() {
        Bus.publish('proposal.retrieve', this.retrieveId());
    },

    subscribe: function() {
        Bus.subscribe('proposal.retrieved', this.allowQuestioning.bind(this));
    }

});
