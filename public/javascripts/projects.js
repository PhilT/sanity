$(function(){
  function updateProjects(){
    $.get(document.URL + '.js', null, function(data, status){$('#content').html(data)}, 'html');
  }

  if($('#projects')){
    setInterval(updateProjects, 60000);
  }
})

