$(function(){
    $('#score-option img').on('click', function() {
        var s = $(this).prop('src').split("/");
        var o = s[s.length - 1].split("_");
        var score = o[0];
        var popped = s.pop();
        
        $('#score-option img').map(function(){
           return $(this).prop("src", $(this).prop("src").replace("_active", "_inactive")); 
        });
        
        $(this).prop("src", s.join("/") + "/" + score + "_active.svg");
        $("#formScore-score").val(score);
        $('#formScore-next').prop("disabled", "");
    });
    
    $('#formScore input[type="checkbox"]').on('change', function() {
       if($('#formScore input[type="checkbox"]:checked').length > 0) {
            $('#formScore-next').prop("disabled", "");   
       } else {
           $('#formScore-next').prop("disabled", "disabled");   
       }
    });
    
    $('#formScore textarea').on('keyup', function() {
       if($(this).val().length > 0) {
            $('#formScore-next').prop("disabled", "");   
       } else {
           $('#formScore-next').prop("disabled", "disabled");   
       }
    });
});