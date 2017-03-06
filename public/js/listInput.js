var ListInput = function(){
  var listInput = document.getElementById('list-input');

  var sendContent = function(){
    var content = listInput.value;
    Bus.publish('send content', content);
  };

  Bus.subscribe('button clicked', sendContent);
}
