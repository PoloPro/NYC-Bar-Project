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
      $('#ach-needs-backgroud').attr("style", "background-color: white;");
    }, 1500);

    $('body').append('<div class="overlay"></div>');
  }, 50);
}

function closeNotification() {
  $('.pull').fadeOut(1000)
}

var popupAchievement = function(response) {
  $(function() {
    var content, name, points;
    $('.pull').removeClass('hidden-achievement');
    name = response.achievement.name;
    content = response.achievement.content;
    points = response.achievement.points;
    $('#ach-name').html('<center><strong><h4>' + name + '<h4></strong></center>');
    $('#ach-content').html('<center>' + content + '</center>');
    $('.notification').addClass('notification-hidden');
    openNotification('positive');
    setTimeout(closeNotification, 5000);
  });
};
