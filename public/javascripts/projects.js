$(function(){
  setInterval("$.get(document.URL + '.js', null, function(data, status){$('#content').html(data)}, 'html')", 60000);
})

