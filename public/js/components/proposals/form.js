var Form = function() {
    new Submit();
    new FinishCircle();
    new Title();
    new Content();
    new InfoMessage();

    var proposalData = {};
    var form = document.getElementById('proposal-form');
    form.style.visibility = 'hidden';

    var show = function() {
        form.style.visibility = 'visible';
    };

    var hide = function() {
        form.style.visibility = 'hidden';
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
    Bus.subscribe('proposal.submit', hide);
};
