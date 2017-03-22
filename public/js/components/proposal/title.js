var Title = function() {
    var title = document.getElementById('proposal-title');

    var publishContent = function () {
        Bus.publish('proposal.title.change', title.value);
    };

    var emptyTitle = function () {
        title.value = '';
        Bus.publish('proposal.title.change', '');
    };

    Bus.subscribe('proposal.title.empty', emptyTitle);

    title.addEventListener('input', publishContent);
};
