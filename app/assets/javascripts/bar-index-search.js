$(document).ready(function() {

  var listOptions = {
    valueNames: [ 'name', 'category' ],
  };

  var wrapperElement = $('#bar-list-searchable')
  var barIndexList = new List(wrapperElement[0], listOptions);

})