var Form = function() {
    new Submit();
    new FinishCircle();
    new Title();
    new Content();
    new InfoMessage();

    var proposalData = {};
    var form = document.getElementById('proposal-form');

    var show = function() {
        form.style.display = 'block';
    };

    var hide = function() {
        form.style.display = 'none';
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

    hide();

    Bus.subscribe('proposal.empty', empty);
    Bus.subscribe('proposal.new', show);
    Bus.subscribe('proposal.title.change', titleChange);
    Bus.subscribe('proposal.content.ready', contentChange);
    Bus.subscribe('proposal.submit', addProposal);
    Bus.subscribe('proposal.added', hide);
};
