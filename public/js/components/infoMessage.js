var InfoMessage = function() {
    var infoMessage = document.getElementById('info-message');

    var hide = function() {
        infoMessage.style.visibility = 'hidden';
    };

    var show = function() {
        infoMessage.style.visibility = 'visible';
    };

    Bus.subscribe('enoughProposalContent', hide);
    Bus.subscribe('notEnoughProposalContent', show);
};
