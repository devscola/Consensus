var Proposal = function(id) {
    var my_id = id;
    var title = document.getElementById('title');
    var content = document.getElementById('content');

    var render = function(data) {
        title.innerHTML = data.title;
        content.innerHTML = data.content;
    };

    Bus.subscribe('proposal.retrieved',render);
    Bus.publish('proposal.retrieve',my_id);
};
