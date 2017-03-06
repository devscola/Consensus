var ListSubmit = function(){
  var listSubmit = document.getElementById('list-submit');

  var buttonClicked = function(){
    Bus.publish('button clicked');
  };

  listSubmit.addEventListener('click', buttonClicked);  
}
