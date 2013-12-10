# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ->
  $('.reviewform').on('click', 'button', ->
    $(this).closest('.reviewform').find('.add_review').slideToggle())

  $('.education-toggle').on('click', 'button', ->
    $(this).closest('.education-toggle').find('.add_education').slideToggle())

  $('.position-toggle').on('click', 'button', ->
    $(this).closest('.position-toggle').find('.add_position').slideToggle())

  $('.language-toggle').on('click', 'button', ->
    $(this).closest('.language-toggle').find('.add_language').slideToggle())

  $("#addresspicker").addresspicker()