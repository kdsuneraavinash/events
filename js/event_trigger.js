// DEPENDANCY: JQuery
// DEPENDANCY: firebase-auth

/*
 * Uses firebase auth to login
*/

var playState = 'animation-play-state';

function onLoginButtonClicked() {
    var wrongLogin = $("#wrong_login");
    wrongLogin.css("display", "none");
    
    $("#user_login_image").css(playState, 'running');

    var email = $('#email').val();
    var password = $('#password').val();

    console.log("Login button clicked");
    signIn(email, password);
}


function onLogoutButtonClicked() {
    $("#user_logout_image").css(playState, 'running');
    signOut();
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

$(document).ready(function() {
    $("#user_login_image").css(playState, 'paused');
    $("#user_logout_image").css(playState, 'paused');
});