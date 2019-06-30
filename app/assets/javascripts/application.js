//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require_tree .
//= require jquery3
//= require popper
//= require bootstrap-sprockets
//= require bootstrap

$(function(){
  $(document).on('ajax:success', 'form', function(e){
    var data=e.detail[0];
    $('.ajax-content').prepend('<p>'+e.detail[0]+'</p>');
  });
});