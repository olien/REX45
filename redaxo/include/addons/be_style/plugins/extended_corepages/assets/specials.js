jQuery(function($){
  $('#phpinfo table').css({width:'100%'}).addClass('rex-table');
  $('#phpinfo :header:not(.p)').addClass('rex-hl2');
  $('#phpinfo a').each(function(){
    if(typeof $(this).attr("name") != 'undefined'){
      var link = '<a href="#' + $(this).attr("name") + '">' + $(this).text() + '</a> | ';
      $('#phpinfo-anchors').html($('#phpinfo-anchors').html() + link);
    }
  });
});

(function($){
  $('.trigger').click(function(){
    d = $(this).data();
    $(d.target)[d.func](300);
  });
})(jQuery);
