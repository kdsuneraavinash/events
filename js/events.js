/*
 * Uses firebase auth to login
 */
function onLoginButtonClicked() {
    var wrongLogin = $("#wrong_login");
    wrongLogin.css("display", "none");

    var email = $('#email').val();
    var password = $('#password').val();

    console.log("Login button clicked");
    signIn(email, password, wrongLogin);
}



$("#isAllDay").click(onIsAllDayClicked);

function onIsAllDayClicked() {
    // Collapse and uncollapse time select
    $("#collapseTimeSelect.collapse").collapse('toggle');
}


function onImagePreviewClicked(elem) {
    // Tag image view modal
    $("#imagebox").attr('src', '');
    $("#imagebox").attr('src', $(elem).prop('value'));
    console.log("#imagebox property set to " + $(elem).prop('value'));
}