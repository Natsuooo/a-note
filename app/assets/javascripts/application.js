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
//  ('.fade-in').fadeIn(3000);
  /* bootstrapのtooltipを有効にする */
  $('[data-toggle="tooltip"]').tooltip();
  
//  var page=$('.mobile-history').html();
//  history.replaceState({page: page}, null, '');
//  console.log('mobile_memo_items.js.erb');
  
//  /* pushStateを利用して、戻る、進むボタンを押したときの挙動を制御 */
//  var page=$('.mobile-history').html();
//  history.replaceState({page: page}, null, '');
//  console.log('application');
//  $(window).on('popstate', function(e){
//    if(e.originalEvent.state!=null){
//      console.log('app.js'); console.log(e.originalEvent.state);
//      
//      $(".mobile-history").html(e.originalEvent.state.page);
//    }else{
//      console.log('null');
//    }
//  });
//  
//  var page=$('.history').html();
//  history.replaceState({page: page}, null, '');
//  console.log('pc');
//  $(window).on('popstate', function(e){
//    if(e.originalEvent.state!=null){
//      console.log('pc.js'); console.log(e.originalEvent.state);
//
//      $(".history").html(e.originalEvent.state.page);
//    }else{
//      console.log('null');
//    }
//  });
});

//  history.pushState(null, null, '');
//  history.pushState({page: "application.js.erb, pushstate"}, null, '');
//history.replaceState({page: "application.js"}, null, '');




