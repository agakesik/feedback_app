$(document).on "turbolinks:load", ->
  $('.js-toggle').click ->
    $("#change-status-confirmation").css("opacity", "0")
    $("#change-status-confirmation").css("height", "0")
    toggle = @id
    $('#'+toggle+'-show').toggle("blind")
