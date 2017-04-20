Class('DiscussionBoard.Questioner', {

    Extends: Component,

    initialize: function(proposalId) {
        this.proposalId = proposalId;
        DiscussionBoard.Questioner.Super.call(this, 'questioner');
        this.element.addEventListener('openTextarea', this.showTextarea.bind(this));
        this.element.addEventListener('questionSubmit', this.enableQuestionButton.bind(this));
        this.involvedInCircle();
        this.retrieveAuthor();
        this.questionForm = document.getElementById('question-content');
    },



    involvedInCircle: function() {
        var token = localStorage.getItem('authorized');
        var data = {'id': this.proposalId, 'token': token};
        Bus.publish('proposal.validate.user', data);
    },

    userValidation: fopenTextareaunction(result) {
        if (result.valid) {
            this.showButton();
        }
    },

    showButton: function() {
        this.element.buttonVisibility = true;
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
        this.element.enabledQuestion = false;
    },

    showTextarea: function() {
        this.questionForm.activated = true;
    },

    subscribe: function() {
        Bus.subscribe('proposal.user.validated', this.userValidation.bind(this));
        Bus.subscribe('logged.user', this.loggedUser.bind(this));
        Bus.subscribe('proposal.question.added', this.enableQuestionButton.bind(this));
    }

});
