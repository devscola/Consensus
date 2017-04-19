Class('DiscussionBoard.QuestionContent', {

    Extends: Component,

    initialize: function() {
        DiscussionBoard.QuestionContent.Super.call(this, 'question-content');
    },

    _showTextarea: function() {
        this.element.textboxVisibility = true;
    },

    subscribe: function() {
        Bus.subscribe('discussion-board.show-textarea', this._showTextarea.bind(this));
    }

});
