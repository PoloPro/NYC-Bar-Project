$(document).ready(function() {

  var listOptions = {
    valueNames: [ 'name', 'category' ],
  };

  var wrapperElement = $('#bar-search-area')
  var barIndexList = new List(wrapperElement[0], listOptions);

})