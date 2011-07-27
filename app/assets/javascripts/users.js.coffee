# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$(document).ready ->
  $('.tab_content').hide()
  $('ul.tabs li:first').addClass("active").show()
  $(".tab_content:first").show()
  $("ul.tabs li").click ->
    $("ul.tabs li").removeClass("active")
    $(this).addClass("active")
    $(".tab_content").hide()
    activeTab = $(this).find("a").attr("href")
    $(activeTab).fadeIn()
    false
