$('#modalNewQuestion').on('shown.bs.modal', function (e) {
    $('#description').val('');
    $('#typeId').val('');
    $('#questionId').val($(e.relatedTarget).data('id'))
    if ($(e.relatedTarget).data('id')) {
        var target = $(e.relatedTarget);
        $('#description').val(target.data('description'));
        $('#typeId').val(target.data('typeid'));
    }
});

sendForm(function() {
    getContent('./partialView/_listQuestion.jsp' + location.search, "tbody");
    $('#modalNewQuestion').modal('hide');
}, function() {});