$("#hidden_new_review").hide();

newReviewListener = ->
  $('#new_review').submit (e) ->
    data = {}
    review = {}
    review['rating'] = $('#review_rating').val()
    review['content'] = $('#review_content').val()
    review['user_id'] = $('#review_user_id').val()
    review['bar_id'] = $('#review_bar_id').val()
    data['review'] = review
    $.ajax
      type: 'POST'
      url: '/reviews/'
      data: data
      success: (response) ->
        $('#hidden_review_rating').text($('#review_rating').val())
        $('#hidden_review_content').text($('#review_content').val())
        $('#hidden_review').show()
    return
  return

$(document).ready ->
  $('#hidden_review').hide()
  newReviewListener()
  return