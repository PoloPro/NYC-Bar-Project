var unfollowHover = function(){
  $(".btn-unfollow").hover(function(){
    $(this).addClass('btn-danger').removeClass('btn-secondary')
    $(this).val('Unfollow')
  }, function(){
    $(this).addClass('btn-secondary').removeClass('btn-danger')
    $(this).val('Following')
  })
}

  
$(document).ready(function(){
  unfollowHover()
})

$('.follow-button-area').on('click', '.btn', function(){
  debugger
})