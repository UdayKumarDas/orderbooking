# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
jquery ->
  
menus= $('#offer_menuName_get').html()

$('#offer_catId_get').change ->
   category= $('#offer_catId_get :selected').text()
   options = $(menus).filter("optgroup[lable='#{category}']").html()
  if options
    $('#offer_menuName_get').html(options)
  else
  $('#offer_menuName_get').empty()
