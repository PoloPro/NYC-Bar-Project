$(document).ready ->
  newReviewListener()
  deleteReviewListener()
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
  html = ""
  html += '<div class="card-outer-border">'
  html += '<div class="card">'
  html += '<div class="card-block card-text">'
  html += '<p>' + response['review']['content'] + '</p>'
  html += '<div class="text-xs-right">' 
  mug = '<img src="/assets/ratings/rating-full-x-small.png">'
  i = 0
  while i < response['review']['rating']
    html += mug
    i++
  html += '</div>'
  html += '</div>'
  html += '<div class="card-footer"> <div>'
  html += '<a href="/users/' + response['user']['id'] + '">'
  html += '<img src="' + response['user']['picture'] + '"alt="profile picture" width="50px" height="50px" class="profile-pic" style="float:left; margin:0px 10px;">'
  html += response['user']['name']
  html += '</a>'
  html += '</div>'
  html += '<div>'
  created_at = response['review']['created_at'].slice(0, 10) + " " + response['review']['created_at'].slice(11, 19) + " UTC" 
  html += '<small><em>' + created_at + '</em></small>'
  html += '</div> </div> </div> </div>'
  html += '<div class="text-xs-right">'
  html += '<a href="/reviews/' + response['review']['id'] + '/edit"> Edit</a>'
  html += '<span id="ajax_page_delete_review" class="delete_review">'
  html += '<a href="/reviews/' + response['review']['id'] + '"> Delete</a>'
  html += '</span><br><br></div>'
  $('#new_review').html(html)
  return

newReviewListener = ->
  $('#new_review_form').submit (e) ->
    e.stopPropagation()
    e.preventDefault()
    $.ajax
      type: 'POST'
      data: getFormData()
      url: '/reviews/'
      success: (response) ->
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
  if $('#new_review').html() == ""
    $('#all_reviews').children().first().next().remove()
    $('#edit-and-delete-links').html('')
    return
  else
    $('#new_review').html('')
    return

deleteReviewListener = ->
  $('.delete_review').click (e) ->
    e.stopPropagation()
    e.preventDefault()
    if confirm('Are you sure you want to delete this review?')
      url = $('.delete_review > a').attr('href')
      $.ajax
        type: 'DELETE'
        url: url
        data: parseInt(url.split("/")[2])
        success: (response) ->
          removeReview()
          $('#new_review_form').show()
          newReviewListener
          return
        error: (response) ->
          alert("Unable to delete review")
          return
      return
    else
      e.preventDefault()
      return
  return

newReviewListener = ->
  $('#new_review_form').submit (e) ->
    e.stopPropagation()
    e.preventDefault()
    $.ajax
