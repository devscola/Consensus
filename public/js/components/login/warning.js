var Warning = function() {
    var element = document.getElementById('error');
    var dismiss = document.getElementById('dismiss-error');

    var show = function() {
        element.style.display = 'block';
    };

    var hide = function() {
        element.style.display = 'none';
    };

    dismiss.addEventListener('click', function() {
        hide();
    });

    hide();

    Bus.subscribe('warning.show', show);
    Bus.subscribe('warning.hide', hide);

    return {
        element: element,
        show: show,
        hide: hide
    };
};
