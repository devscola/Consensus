var Proposal = function(id) {
    var my_id = id;
    var title = document.getElementById('title');
    var content = document.getElementById('content');
    var circle = document.getElementById('circle');

    var render = function(data) {
        title.innerHTML = data.title;
        content.innerHTML = data.content;
        circleContent = populateCircle(data.circle);
        circle.innerHTML = circleContent;
    };

    var populateCircle = function(circle) {
        var list = '';
        circle.forEach(function(username) {
            list += '<li class="user-involved list-group-item">' + username + '</li>';
        });
        return list;
    };

    Bus.subscribe('proposal.retrieved', render);
    Bus.publish('proposal.retrieve', my_id);
};
