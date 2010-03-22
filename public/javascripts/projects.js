$(function(){
  function updateProjects(){
    $.get('/projects.js', null, function(data, status){$('#content').html(data)}, 'html');
  }

  if($('#projects')[0]){
    setInterval(updateProjects, 60000);
  }
})

