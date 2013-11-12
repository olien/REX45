(function($){
  $(".extended_corepages tr.rex-addon td.rex-col-a").click(function(){
    TR = $(this).parent('tr');
    if(TR.hasClass('collapsed')){
      TR.nextUntil('tr.rex-addon').find('td').wrapInner('<div style="display: none;" />').parent().show().find('td > div').slideDown(200, function(){var $set = $(this);$set.replaceWith($set.contents());TR.removeClass('collapsed');});
    }else{
      TR.nextUntil('tr.rex-addon').find('td').wrapInner('<div style="display: block;" />').parent().find('td > div').slideUp(200, function(){$(this).parent().parent().hide();TR.addClass('collapsed');var $set = $(this);$set.replaceWith($set.contents());});
    }
  });
})(jQuery);
