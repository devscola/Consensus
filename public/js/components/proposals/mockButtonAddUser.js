var mockButtonAddUser = function() {
    var button = document.getElementById('mock-add-user');

    var addUser = function() {
        Bus.publish('add-user');
    }

    button.addEventListener('click', addUser);
}