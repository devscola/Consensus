var Warning = function() {
    var element = document.getElementById('error');
    var dismiss = document.getElementById('dismiss-error');

    var show = function() {
        element.style.display = 'block';
    };

    var hide = function() {
        _doHide();
        Bus.publish('dismissed');
    };

    var _doHide = function() {
        element.style.display = 'none';
    };

    var _start = function() {
        dismiss.addEventListener('click', hide);
        _doHide();
    };

    _start();

    return {
        element: element,
        show: show,
        hide: hide
    };
};
