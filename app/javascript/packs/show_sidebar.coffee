$(document).on "turbolinks:load", ->
  $('#sidebar-toggle').click ->
    $('#sidebar').toggleClass("sidebar-show")
