var TextArea = function(){
  var textArea = document.getElementById('proposal-content');
  var counter = document.getElementById('counter');
  var MIN_PROPOSAL_CONTENT = 1000

  var updateCounter = function() {
    var characterAmount = textArea.textLength;

    counter.innerHTML = characterAmount;

    if (characterAmount >= MIN_PROPOSAL_CONTENT) {
      Bus.publish('enoughProposalContent');
    };

    if (characterAmount < MIN_PROPOSAL_CONTENT) {
      Bus.publish('notEnoughProposalContent');
    };
  };

  updateCounter();
  textArea.addEventListener('keyup', updateCounter);
}
