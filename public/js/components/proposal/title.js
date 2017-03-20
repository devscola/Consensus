var Title = function() {
    var title = document.getElementById('proposal-title');

    var publishContent = function () {
        Bus.publish('proposal.title.change', title.value);
    };

    title.addEventListener('input', publishContent);
};
