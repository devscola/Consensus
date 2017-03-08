var ProposalForm = function() {
    new Button();
    new ProposalTitle();
    new TextArea();
    new InfoMessage();

    var proposalForm = document.getElementById('proposal-form');
    proposalForm.style.visibility = 'hidden';
    
    var show = function() {
        proposalForm.style.visibility = 'visible';    
    };

    Bus.subscribe('new proposal', show);
};
