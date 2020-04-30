$(document).on "turbolinks:load", ->
  $('.js-toggle').click ->
    $("#change-status-confirmation").fadeOut(300)
    toggle = @id
    $('#'+toggle+'-show').slideToggle(500)
