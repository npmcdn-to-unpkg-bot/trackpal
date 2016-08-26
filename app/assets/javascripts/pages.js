$(document).ready(function() {

  //Parallax
  var $body = $('body');
  $(window).on('scroll', function(){
    var scrollTop = $(window).scrollTop();
    $body.css('background-position-y', -scrollTop/3);
    // if( scrollTop > 500 ){
    //   $body.css('background-image', 'url(http://fillmurray.com/900/800)');
    //
    // }
    // if( scrollTop < 500 ){
    //   $body.css('background-image', 'url(http://fillmurray.com/1000/800)');
    //
    // }

  });

});
