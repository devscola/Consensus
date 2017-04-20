Class('DiscussionBoard.QuestionContent', {

    Extends: Component,

    initialize: function() {
        DiscussionBoard.QuestionContent.Super.call(this, 'question-content');
    },

    disableQuestionForm: function() {
        this.element.textboxVisibility = false;
    },

    _showTextarea: function() {
        this.element.textboxVisibility = true;
    },

    subscribe: function() {
        Bus.subscribe('proposal.question.added', this.disableQuestionForm.bind(this));       
        Bus.subscribe('discussion-board.show-textarea', this._showTextarea.bind(this));
    }

});
