var Submit = function() {
    var submit = document.getElementById('proposal-submit');

    var submitProposal = function() {
        Bus.publish('proposal.submit');
    };

    submit.addEventListener('click', submitProposal);

    var activateButton = function() {
        submit.disabled = false;
    };

    var deactivateButton = function() {
        submit.disabled = true;
    };

    Bus.subscribe('proposal.content.ready', activateButton);
    Bus.subscribe('proposal.content.not.ready', deactivateButton);
};
