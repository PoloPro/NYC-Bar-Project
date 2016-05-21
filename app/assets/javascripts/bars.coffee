$("#hidden_review").hide();

updateAverageRating = ->
  if $('.review').length == 0
    $('#avg_rating').text ' ' + $('#review_rating').val()
  else
    avg_rating = (parseInt($('#avg_rating').text()) + parseInt($('#review_rating').val())) / ($('.review').length + 1)
    $('#avg_rating').text ' ' + avg_rating
  return

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
        $('#hidden_review_rating').append($('#review_rating').val())
        $('#hidden_review_content').text($('#review_content').val())
        updateAverageRating()
        $('#edit_review_url').attr('href', "/reviews/" + response["id"] + "/edit")
        $('#hidden_review').show()
        $('#new_review_form').hide()
      error: (response) ->
        alert("Invalid review")
        return
    return
  return

$(document).ready ->
  $('#hidden_review').hide()
  newReviewListener()
  return