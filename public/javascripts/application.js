$(function(){
  setInterval("$.get(document.URL, null, function(data, status){$('#content').html(data)}, 'html')", 60000);
})

