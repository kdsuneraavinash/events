/*
 * Uses firebase auth to login
 */
function onLoginButtonClicked() {
    var wrongLogin = $("#wrong_login");
    wrongLogin.css("display", "none");

    var email = $('#email').val();
    var password = $('#password').val();

    signIn(email, password, wrongLogin);

    // Must return false to avoid form from submitting
    return false;
}



$("#isAllDay").click(onIsAllDayClicked);

function onIsAllDayClicked() {
    $("#collapseTimeSelect.collapse").collapse('toggle');
}

function onImagePreviewClicked(elem) {
    $("#imagebox").attr('src', '');
    $("#imagebox").attr('src', $(elem).prop('value'));
}