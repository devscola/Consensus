var WrongCredentials = function() {

  var element = document.getElementById('error');
  var dismiss = document.getElementById('dismiss-error');

  var show = function() {
    element.style.display = 'block';
  }

  var hide = function() {
    element.style.display = 'none';
  }

  dismiss.addEventListener('click', function() {
    hide();
    Bus.publish('dismissed');
  });

  hide();

  return {
    element: element,
    show: show,
    hide: hide
  }
}
