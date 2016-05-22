$(document).ready(function() {

  var paginationBottomOptions = {
    name: "paginationTop",
    paginationClass: "paginationTop",
    innerWindow: 1,
    outerWindow: 1
  }

  var paginationBottomOptions = {
    name: "paginationBottom",
    paginationClass: "paginationBottom",
    innerWindow: 1,
    outerWindow: 1
  }

  var listOptions = {
    valueNames: [ 'name', 'category' ],
    page: 20,
    plugins: [
    ListPagination(paginationTopOptions),
    ListPagination(paginationBottomOptions)
    ]
  };

  var wrapperElement = $('#bar-index')
  var barIndexList = new List(wrapperElement[0], listOptions);

})