main();

function main() {
  document.addEventListener('DOMContentLoaded', function() {
    new textAreaPage();
  });
}

var textAreaPage = function(){
  var textArea = document.getElementById('text-area');
  var counter = document.getElementById('counter');

  var updateCounter = function() {
    counter.innerHTML = textArea.textLength;
  };

  updateCounter();
  textArea.addEventListener('keyup', updateCounter);

  return {}
}
