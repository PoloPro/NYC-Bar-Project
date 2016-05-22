$(document).ready ->
  $('#hidden_user_name').hide()
  newReviewListener()


updateAverageRating = (response)  ->
  new_rating = response["rating"]
  number_Of_Reviews = $('.review').length
  if number_Of_Reviews == 1
    $('#avg_rating').text ' ' + new_rating
  else
    old_avg_rating = parseInt($('#avg_rating').text())
    avg_rating = (old_avg_rating + new_rating) / number_of_reviews
    $('#avg_rating').text ' ' + avg_rating
  return

getData = ->
  data = {}
  review = {}
  review['rating'] = $('#review_rating').val()
  review['content'] = $('#review_content').val()
  review['user_id'] = $('#review_user_id').val()
  review['bar_id'] = $('#review_bar_id').val()
  data['review'] = review
  return data

renderNewReview = (response) ->
  user_html = "<strong>Written By: </strong><a href='/users/" + response['user_id'] + "'>" + $('#hidden_user_name').text() + "</a><br>"
  rating_html = "<strong>Rating: </strong>" + response["rating"] + "<br>"
  content_html = "<p>" + response["content"] + "</p>"
  edit_html = "<a href='../reviews/" + response["id"] + "/edit'>Edit</a>"
  $('#new_review').html(user_html + rating_html + content_html + edit_html)

newReviewListener = ->
  $('#new_review_form').submit (e) ->
    $.ajax
      type: 'POST'
      url: '/reviews/'
      data: getData()
      success: (response) ->
        updateAverageRating(response)
        renderNewReview(response)
        $('#new_review_form').hide()
      error: (response) ->
        alert("Invalid review")
  return


