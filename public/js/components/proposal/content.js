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

    var emptyContent = function() {
        content.value = '';
        Bus.publish('proposal.content.not.ready');
    };

    var emptyCounter = function(){
        counter.innerHTML = 0;
    };

    Bus.subscribe('proposal.counter.empty', emptyCounter);
    Bus.subscribe('proposal.content.empty', emptyContent);

    updateCounter();
    content.addEventListener('input', updateCounter);
};


