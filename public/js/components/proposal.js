var Proposal = function(id) {

    var title = document.getElementById('title');
    var content = document.getElementById('content');

    var doRequest = function(endpoint, id, callback) {
        var request = new XMLHttpRequest();
        var OK = 200;

        request.open('POST', endpoint);
        request.setRequestHeader('Content-Type', 'application/json');
        request.onreadystatechange = function() {
            if (request.readyState === XMLHttpRequest.DONE) {
                if (request.status === OK) {
                    callback (JSON.parse(request.responseText));
                }
            }
        };
        request.send(JSON.stringify(id));
    };

    doRequest('/proposals/search', id, function(result) {
        console.log(result);
    });

    doRequest();

    var retrieveProposal = function(id) {

        title.innerHTML = proposal.title;
        content.innerHTML = proposal.content;
    };

    // retrieveProposal(id);

    // title.innerHTML = 'an_expected_title';

};
