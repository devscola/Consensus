Class('DiscussionBoard.Circle', {

    Extends: Component,

    initialize: function() {
        DiscussionBoard.Circle.Super.call(this, 'circle');
    },

    render: function(data) {
        var circleContent = this.populateCircle(data.circle);
        this.element.append(circleContent);
    },

    populateCircle: function(circle) {
        var addProposer = 'Khaleesi';
        var listItems = document.createDocumentFragment();
        listItems.append(this.createListItem(addProposer));
        circle.forEach(function(username) {
            listItems.append(this.createListItem(username));
        }.bind(this));
        return listItems;
    },

    createListItem: function(username) {
        listItem = document.createElement('li');
        listItem.className = 'user-involved list-group-item';
        listItem.innerHTML = username;
        return listItem;
    },

    subscribe: function() {
        Bus.subscribe('proposal.retrieved', this.render.bind(this));
    }

});
