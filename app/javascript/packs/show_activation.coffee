$(document).on "turbolinks:load", ->
  $('#activation-toggle').click ->
    $('#activation-option').toggle("js-content-show");
