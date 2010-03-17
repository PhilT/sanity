$(function(){
  setInterval(checkForNewBuilds, 60000);

  $('.more a').live('click', function(){
    var div = $(this).parent();
    div.siblings('.detail').slideDown();
    div.attr('class', 'less');
    $(this).html('less...');
    return false;
  });

  $('.less a').live('click', function(){
    var div = $(this).parent();
    div.siblings('.detail').slideUp();
    div.attr('class', 'more');
    $(this).html('more...');
    return false;
  });

  function checkForNewBuilds(){
    var last_build = $('#builds a').attr('href');
    last_build = last_build.substr(last_build.lastIndexOf('/') + 1);
    $.get(document.URL + '.js?since=' + last_build, null, prependNewBuilds, 'html');
  }

  function prependNewBuilds(data, status){
    $('.build').eq(0).remove();
    $('#builds').prepend(data).slideDown('slow');
  }

})

