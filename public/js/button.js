main();

function main() {
  document.addEventListener('DOMContentLoaded', function() {
    new Button();
    new Checkbox();
  });
}

var Button = function() {

  var button = document.getElementById('conditionedButton');

  var toggleActivation = function() {
    if (button.disabled === true) {
      activateButton();
    } else {
      deactivateButton();
    }
  };

  var activateButton = function() {
    button.disabled = false;
  };

  var deactivateButton = function() {
    button.disabled = true;
  };

  Bus.subscribe('checkboxClicked', toggleActivation);

};

var Checkbox = function() {

  var checkbox = document.getElementById('condition');

  var toggleCondition = function() {
    Bus.publish('checkboxClicked');
  };

  checkbox.addEventListener('click', toggleCondition);

};
