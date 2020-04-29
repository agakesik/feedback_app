$(document).on "turbolinks:load", ->
  $('.js-toggle').click ->
    toggle = @id
    $('#'+toggle+'-show').toggle("js-content-show");
