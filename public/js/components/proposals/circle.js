var Circle = function () {
    var circle = document.getElementById('circle');
    var showUsers = function (result) {
        console.log(result);
    }
    Bus.subscribe('users.retrieved', showUsers);
} 