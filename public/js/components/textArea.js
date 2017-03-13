var TextArea = function(){
    var textArea = document.getElementById('proposal-content');
    var counter = document.getElementById('counter');
    var MIN_PROPOSAL_CONTENT = 1000;

    var updateCounter = function() {
        var characterAmount = textArea.textLength;

        counter.innerHTML = characterAmount;

        if (characterAmount >= MIN_PROPOSAL_CONTENT) {
            Bus.publish('proposal.content.ready', textArea.value);
        }

        if (characterAmount < MIN_PROPOSAL_CONTENT) {
            Bus.publish('proposal.content.not.ready');
        }
    };

    updateCounter();
    textArea.addEventListener('input', updateCounter);
};
