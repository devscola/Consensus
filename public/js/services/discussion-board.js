Class('Services.DiscussionBoard', {

    Extends: Service,

    initialize: function() {
        Services.DiscussionBoard.Super.call(this, '/proposals');
    },

    addQuestion: function(questionData) {
        this.doRequest(this.baseUrl + '/add/question', questionData, function(result) {
            Bus.publish('proposal.question.added', result);
        });
    },

    subscribe: function() {
        Bus.subscribe('proposal.question.add', this.addQuestion.bind(this));
    }

});


