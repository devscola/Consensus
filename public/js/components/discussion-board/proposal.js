var Proposal = function(id) {

    var my_id = id;
    var title = document.getElementById('title');
    var content = document.getElementById('content');
    var circle = document.getElementById('circle');

    var render = function(data) {
        title.innerHTML = data.title;
        content.innerHTML = data.content;
        circleContent = populateCircle(data.circle);
        circle.append(circleContent);
    };

    var createListItem = function(username) {
        listItem = document.createElement('li');
        listItem.className = 'user-involved list-group-item';
        listItem.innerHTML = username;
        return listItem;
    };

    var populateCircle = function(circle) {
        var listItems = document.createDocumentFragment();
        circle.forEach(function(username) {
            listItems.append(createListItem(username));
        });
        return listItems;
    };

    Bus.subscribe('proposal.retrieved', render);
    Bus.publish('proposal.retrieve', my_id);

};
