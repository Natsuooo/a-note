//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require_tree .
//= require jquery3
//= require popper
//= require bootstrap-sprockets
//= require bootstrap
//
//$(function(){
//  $(document).on('ajax:success', 'form', function(e){
//    var data=e.detail[0];
//    $('.ajax-show').prepend(
//      '<p>'+data['title']+'</p>'+
//      '<p>'+data['body']+'</p>'
//    );
//    $('.ajax-show').html("<%= escape_javascript(render partial:'micropost')%>");
//    var response=e.detail[0].response;
//    $('.ajax-show').html(response);
//  });
//  
  
//});

//$(function(){
//  $('form').keyup(function(){
//    Rails.fire($('form')[0], 'submit');
//  });
//});

$(function () {
  /* bootstrapのtooltipを有効にする */
  $('[data-toggle="tooltip"]').tooltip();
  
});

