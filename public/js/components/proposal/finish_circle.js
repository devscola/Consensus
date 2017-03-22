var Finish_Circle = function() {
    var button = document.getElementById('proposal-finish');

    var hide = function() {
        button.style.visibility = 'hidden';
    };

    var show = function() {
        button.style.visibility = 'visible';
        disabled();
    };

    var disabled = function() {
        button.disabled = true;
    }
  
    var enabled = function() {
        button.disabled = false;
    }

    Bus.subscribe('proposal.submit', show);
    Bus.subscribe('proposal.new', hide);
    Bus.subscribe('add-user', enabled)
}