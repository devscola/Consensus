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

    var empty = function() {
        Bus.publish('proposal.title.empty');
        Bus.publish('proposal.content.empty');
        Bus.publish('proposal.counter.empty');
    };

    var titleChange = function(title) {
        proposalData.title = title;
    };

    var contentChange = function(content) {
        proposalData.content = content;
    };

    var addProposal = function() {
        Bus.publish('proposal.add', proposalData);
    };

    Bus.subscribe('proposal.empty', empty);
    Bus.subscribe('proposal.new', show);
    Bus.subscribe('proposal.title.change', titleChange);
    Bus.subscribe('proposal.content.ready', contentChange);
    Bus.subscribe('proposal.submit', addProposal);
};
