var Button = function() {
    var button = document.getElementById('proposal-submit');

    var submitProposal = function() {
        Bus.publish('submit proposal');
    };

    button.addEventListener('click', submitProposal);

    var activateButton = function() {
        button.disabled = false;
    };

    var deactivateButton = function() {
        button.disabled = true;
    };

    Bus.subscribe('proposal.content.ready', activateButton);
    Bus.subscribe('proposal.content.not.ready', deactivateButton);
};
