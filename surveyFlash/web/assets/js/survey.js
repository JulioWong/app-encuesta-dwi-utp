$('#modalNewSurvey').on('shown.bs.modal', function (e) {
    $('input').val('');
    $('#surveyId').val($(e.relatedTarget).data('id'))
    if ($(e.relatedTarget).data('id')) {
        var target = $(e.relatedTarget);
        $('#description').val(target.data('description'));
        $('#discount').val(target.data('discount'));
        $('#banner').val(target.data('banner'));
        $('#exp').val(target.data('exp'));
    }
});

sendForm(function() {
    getContent('./partialView/_listSurvey.jsp', "tbody");
    $('#modalNewSurvey').modal('hide');
}, function() {});