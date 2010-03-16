$(function(){
  last_build = $('#builds a').attr('href');
  last_build = last_build.substr(last_build.lastIndexOf('/') + 1);
  setInterval("$.get(document.URL + '.js', null, function(data, status){$('#content').html(data)}, 'html')", 60000);
})

