$(document).on "turbolinks:load", ->
  $('#activation-link').click ->
    $('#activation-option').toggle()
