var Finish_Circle = function() {
    var button = document.getElementById('proposal-finish');

    var hide = function() {
        button.style.visibility = 'hidden';
    };

    var show = function() {
        button.style.visibility = 'visible';
    };

    Bus.subscribe('proposal.submit', show);
    Bus.subscribe('proposal.new', hide);
}