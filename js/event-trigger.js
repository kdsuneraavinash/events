/*
 ************************************************************
 * SIGN IN BUTTON
 ************************************************************
 */
var playState = 'animation-play-state';

function onLoginButtonClicked() {
    var wrongLogin = $("#wrong_login");
    wrongLogin.css("display", "none");
    $("#user_login_image").css(playState, 'running');

    var email = $('#email').val();
    var password = $('#password').val();
    console.log("Login process started");
    signIn(email, password);
}


/*
 ************************************************************
 * SIGN OUT BUTTON
 ************************************************************
 */
function onLogoutButtonClicked() {
    $("#user_logout_image").css(playState, 'running');
    signOut();
}

/*
 ************************************************************
 * IS ALL DAY RADIO
 ************************************************************
 */
$("#isAllDay").click(onIsAllDayClicked);


function onIsAllDayClicked() {
    // Collapse and uncollapse time select
    $("#collapseTimeSelect.collapse").collapse('toggle');
}

/*
 ************************************************************
 * IMAGE PREVIEW BUTTON
 ************************************************************
 */
function onImagePreviewClicked(elem) {
    // Tag image view modal
    $("#imagebox").attr('src', '');
    $("#imagebox").attr('src', $(elem).prop('value'));
    $("#imagelink").attr('href', $(elem).prop('value'));
    console.log("#imagebox property set to " + $(elem).prop('value'));
}
