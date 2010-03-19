$(function(){
  function updateProjects(){
    $.get(document.URL + '.js', null, function(data, status){$('#content').html(data)}, 'html');
  }

  if($('#projects')[0]){
    setInterval(updateProjects, 60000);
  }
})

