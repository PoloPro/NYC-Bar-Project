function openNotification(whichNotification) {
  var thisNotification = $('.notification.' + whichNotification);
  thisNotification.removeClass('notification-hidden');
  setTimeout(function() {
    thisNotification.addClass('open');
    var openNotification = $('.notification.open');
    $('.pull').addClass('open');
    openNotification.addClass('show').addClass('open--rot');

    setTimeout(function() {
      openNotification.addClass('open--width');
    }, 1000);

    setTimeout(function(){
      openNotification.find('.flexx-container').addClass('drop-down');
    }, 1500);

    $('body').append('<div class="overlay"></div>');
  }, 50);
}

function closeNotification() {
  var type = $('.notification.open');


  $('.pull').fadeOut(1000)
}
