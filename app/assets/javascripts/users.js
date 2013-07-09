$(document).ready(function(){
$(document).on('ajax:success', '#remove_trigger', function(event, data, status, xhr) {
   var tr = '#' + data.id
    $(tr).remove()
});
});