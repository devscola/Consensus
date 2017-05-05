Class('DiscussionBoard.Questioner', {

    Extends: Component,

    initialize: function(proposalId) {
        this.proposal = {};
        this.proposalId = proposalId;
        DiscussionBoard.Questioner.Super.call(this, 'question-container');
        this.element.addEventListener('openTextarea', this.showTextarea.bind(this));
        this.element.addEventListener('questionSubmit', this.addQuestion.bind(this));
        this.retrieveAuthor();
        this.questionForm = document.getElementById('question-content');
        this.questionButton = document.getElementById('questioner');
    },

    userValidation: function(result) {
        if (result.valid) {
            this.showButton();
        }
    },

    showButton: function() {
        this.questionButton.validQuestioner = true;
    },

    addQuestion: function() {
        var questionData = {};
        var body = document.getElementById('questionText');
        questionData.proposal_id = this.proposalId;
        questionData.author = this.author;
        questionData.body = body.value;
        Bus.publish('proposal.question.add', questionData);
    },

    retrieveAuthor: function(){
        Bus.publish('proposal.logged.user');
    },

    loggedUser: function(author){
        this.author = author;
    },

    enableQuestionButton: function(result) {
        this.questionButton.buttonActivated = true;
    },

    showTextarea: function() {
        this.questionForm.activated = true;
    },

    retrieveId: function() {
        var url = window.location.href;
        return url.split('discussion-board/')[1];
    },

    holdProposal: function(proposal) {
        this.proposal = proposal;
        Bus.publish('storage.username.retrieve');
    },

    allowQuestioning: function (username) {
        var involved = this.proposal.circle.includes(username);
        var isProposer = (this.proposal.proposer == username);

        this.questionButton.validQuestioner = (involved && !isProposer);
    },

    publish: function() {
        Bus.publish('proposal.retrieve', this.retrieveId());
    },

    subscribe: function() {
        Bus.subscribe('proposal.retrieved', this.holdProposal.bind(this));
        Bus.subscribe('proposal.question.added', this.enableQuestionButton.bind(this));
        Bus.subscribe('storage.username.retrieved', this.allowQuestioning.bind(this));
    }

});
