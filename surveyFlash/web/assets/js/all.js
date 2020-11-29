function sendForm(fn, fnError) {
    $(function(){
        $(".asyncForm").on("submit", function(e) {
            e.preventDefault();
            var dataToPost = $(this).serialize();
            $.post($(this).prop("action"), dataToPost)
            .done(function(response, status, jqxhr){
                fn();
            })
            .fail(function(jqxhr, status, error){ 
                fnError();
            });
        });
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


