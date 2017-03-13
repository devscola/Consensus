var ProposalForm = function() {
    new Button();
    new ProposalTitle();
    new TextArea();
    new InfoMessage();

    var proposalData = {};
    var proposalForm = document.getElementById('proposal-form');
    proposalForm.style.visibility = 'hidden';

    var show = function() {
        proposalForm.style.visibility = 'visible';
    };

    var titleChange = function(title) {
        proposalData.title = title;
    };

    var contentChange = function(content) {
        proposalData.content = content;
    };

    Bus.subscribe('proposal.title.change', titleChange);
    Bus.subscribe('proposal.content.ready', contentChange);
    Bus.subscribe('proposal.new', show);
};
