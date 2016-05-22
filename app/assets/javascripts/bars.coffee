$(document).ready ->
  $('#hidden_user_name').hide()
  newReviewListener()
  deleteReviewListener()
  return


updateAverageRating = (response)  ->
  new_rating = response["rating"]
  numberOfReviews = $('.review').length
  if numberOfReviews > 1
    $('#avg_rating').text ' ' + new_rating
  else
    old_avg_rating = parseInt($('#avg_rating').text())
    avg_rating = (old_avg_rating + new_rating) / numberOfReviews
    $('#avg_rating').text ' ' + avg_rating
  return

getFormData = ->
  review = {}
  review['rating'] = $('#review_rating').val()
  review['content'] = $('#review_content').val()
  review['user_id'] = $('#review_user_id').val()
  review['bar_id'] = $('#review_bar_id').val()
  data = {}
  data['review'] = review
  return data

renderNewReview = (response) ->
  user_html = "<strong>Written By: </strong><a href='/users/" + response['user_id'] + "'>" + $('#hidden_user_name').text() + "</a><br>"
  rating_html = "<strong>Rating: </strong>" + response["rating"] + "<br>"
  content_html = "<p>" + response["content"] + "</p>"
  edit_html = "<a href='../reviews/" + response["id"] + "/edit'>Edit</a>"
  delete_html = "<br><span id='delete_review'><a data-remote='true' href='/reviews/" + response["id"] + "'>Delete</a></span>" 
  $('#new_review').html(user_html + rating_html + content_html + edit_html + delete_html)
  return

newReviewListener = ->
  $('#new_review_form').submit (e) ->
    $.ajax
      type: 'POST'
      data: getFormData()
      url: '/reviews/'
      success: (response) ->
        updateAverageRating(response)
        renderNewReview(response)
        $('#new_review_form').hide()
        deleteReviewListener()
        return
      error: (response) ->
        alert("Invalid review")
        return
    return
  return

removeReview = ->
  if $('.review').length > 1
    $('#all_reviews').first().remove()
    return
  else
    $('#new_review').remove()
    return

deleteReviewListener = ->
  $('#delete_review').click (e) ->
    if confirm('Are you sure you want to delete this review?')
      url = $('#delete_review > a').attr('href')
      $.ajax
        type: 'DELETE'
        url: url
        data: parseInt(url.split("/")[2])
        success: (response) ->
          removeReview()
          return
        error: (response) ->
          alert("Unable to delete review")
          return
      return
    else
      e.preventDefault()
      return
  return

