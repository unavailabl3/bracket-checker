document.addEventListener('DOMContentLoaded', function() {
    $('.type-choice span').click(function() {
        $('.type-choice span').removeClass('selected');
        if($(this).hasClass('single')){
            $('input').show().val('');
            $('textarea').hide();
        } else {
            $('textarea').show().val('');
            $('input').hide();
        }
        $(this).addClass('selected')
    });
    
    $('.check-button').click(function() {
        $('.check-results').html('');
        var expressions = $('span.selected').hasClass('single') ? $('input').val() : $('textarea').val();
        $.ajax({
            url: "/check",
            method: "POST",
            data:
            { expressions: expressions },
            headers: {'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')},
            datatype: "json",
            success: function(data) {
                $('.check-results').append(data);
            }
        });
    });
});