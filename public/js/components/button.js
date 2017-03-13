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

    Bus.subscribe('enoughProposalContent', activateButton);
    Bus.subscribe('notEnoughProposalContent', deactivateButton);
};
