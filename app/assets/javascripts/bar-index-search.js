$(document).ready(function() {

  var listOptions = {
    valueNames: [ 'name', 'category' ],
  };

  var wrapperElement = $('#bar-list')
  var barIndexList = new List(wrapperElement[0], listOptions);

})