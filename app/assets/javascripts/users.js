$(document).ready(function(){
    $(document).on('ajax:success', '#remove_trigger', function(event, data, status, xhr) {
        var tr = '#' + data.id
        $(tr).remove()
    });

    $('.item-menu').on('click', 'li', function(e) {
        e.preventDefault();
        var link = $(this).children('a').attr('href') 
        $('.guest-items').children().addClass("hidden");
        $(link).removeClass("hidden");
        $(link).addClass("active");
    });
});

$(document).ready(function(){
    $(document).on('ajax:success', '#signup', function(event, data, status, xhr) {
      console.log('ajax:success!')
  });
});