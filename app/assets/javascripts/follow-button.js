$('.follow-button-area').hover(function(){
  $('.btn-unfollow').addClass('btn-danger').removeClass('btn-secondary')
  $('.btn-unfollow').val('Unfollow')
}, function(){
  $('.btn-unfollow').addClass('btn-secondary').removeClass('btn-danger')
  $('.btn-unfollow').val('Following')
})