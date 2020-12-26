$(function() {
    $('#modalNewSurvey').on('shown.bs.modal', function (e) {
        $('#formSurvey-description').val("");
        $('#formSurvey-discount').val("");
        $('#formSurvey-banner').val("");
        $('#formSurvey-exp').val("");
        
        $('#formSurvey-surveyId').val($(e.relatedTarget).data('id'))
        if ($(e.relatedTarget).data('id')) {
            var target = $(e.relatedTarget);
            $('#formSurvey-description').val(target.data('description'));
            $('#formSurvey-discount').val(target.data('discount'));
            $('#formSurvey-banner').val(target.data('banner'));
            $('#formSurvey-exp').val(target.data('exp'));
        }
    });
});

function beforeSend(data) {
    if (data.status == "success") {
        $('#modalNewSurvey').modal('hide');
    }
}