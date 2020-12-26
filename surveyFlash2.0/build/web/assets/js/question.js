$(function() {
    $('#modalNewQuestion').on('shown.bs.modal', function (e) {
        $('#formQuestion-description').val('');
        $('#formQuestion-typeId').val('');
        $('#formQuestion-questionId').val($(e.relatedTarget).data('id'))
        if ($(e.relatedTarget).data('id')) {
            var target = $(e.relatedTarget);
            $('#formQuestion-description').val(target.data('description'));
            $('#formQuestion-typeId').val(target.data('typeid'));
        }
    });
});

function openAlternatives(data){
    if (data.status == "success") {
        $('#modalNewAlternatives').modal('show');
    }
}

function closeAlternatives(data){
    if (data.status == "success") {
        $('#formAlternative-descripcionAlternativa').val('').focus();
    }
}