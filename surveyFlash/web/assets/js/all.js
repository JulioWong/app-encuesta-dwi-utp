function sendForm(fn, fnError) {
    $(function(){
        $(document).on({
            submit: function(e) {
                e.preventDefault();
                var dataToPost = $(this).serialize();
                $.post($(this).prop("action"), dataToPost)
                .done(function(response, status, jqxhr){
                    fn();
                })
                .fail(function(jqxhr, status, error){ 
                    fnError();
                });
            }
        }, ".asyncForm");
    });
}

function getContent(path, selector) {
    $(function(){
        $.get(path, function( data ) {
          $(selector).empty();
          $(selector).html( data );
        });
    });
}


