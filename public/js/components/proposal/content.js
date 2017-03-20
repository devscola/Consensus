var Content = function(){
    var content = document.getElementById('proposal-content');
    var counter = document.getElementById('counter');
    var MIN_PROPOSAL_CONTENT = 1000;

    var updateCounter = function() {
        var characterAmount = content.textLength;

        counter.innerHTML = characterAmount;

        if (characterAmount >= MIN_PROPOSAL_CONTENT) {
            Bus.publish('proposal.content.ready', content.value);
        }

        if (characterAmount < MIN_PROPOSAL_CONTENT) {
            Bus.publish('proposal.content.not.ready');
        }
    };

    updateCounter();
    content.addEventListener('input', updateCounter);
};
