$('.follow-button-area').hover(
  function(){var button = $(this).children().children().first()
    if (button.hasClass('btn-unfollow')){
      button.addClass('btn-danger').removeClass('btn-secondary')
      button.val('Unfollow')}
    }, 
  function(){var button = $(this).children().children().first()
    if (button.hasClass('btn-unfollow')){
        button.addClass('btn-secondary').removeClass('btn-danger')
        button.val('Following')}
    })