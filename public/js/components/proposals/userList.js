var UserList = function() {
    var list = document.getElementById('user-selection');
    var proposal = null;

    var show = function() {
        list.style.visibility = 'visible';
    };

    var start = function(data) {
        proposal = data;
        show();
    }

    var hide = function() {
        list.style.visibility = 'hidden';
    };

    hide();

    Bus.subscribe('proposal.added', start)
};
