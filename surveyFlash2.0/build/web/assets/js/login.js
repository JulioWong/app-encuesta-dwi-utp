$(function(){
    $("#formLogin").on("submit", function(e) {
        e.preventDefault();
        var dataToPost = $(this).serialize();
        $.post($(this).prop("action"), dataToPost)
        .done(function(response, status, jqxhr){ 
            if(response === "true") window.location.href = './survey.jsp';
            else {
                $("#alertLogin").text(response).show();
            }
        })
        .fail(function(jqxhr, status, error){ 
        });
    });
});