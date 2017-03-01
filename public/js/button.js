var Button = function() {
  var button = document.getElementById('proposal-submit');

  var activateButton = function() {
    button.disabled = false;
  };

  var deactivateButton = function() {
    button.disabled = true;
  };

  Bus.subscribe('enoughProposalContent', activateButton);
  Bus.subscribe('notEnoughProposalContent', deactivateButton);
};
