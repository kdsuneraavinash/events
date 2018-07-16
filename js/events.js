/*
 * When loggin button is clicked this works as validation function
 * But the problem is when data is sent to php file, page is refreshed
 * To stay in the same page this will use an Ajax function
 * which will call php file in the background and send echoed message
 * Then depending on message page will either refresh or show an error message
 */
function onLoginButtonClicked(){
    var wrongLogin = $("#wrong_login");
    wrongLogin.css("display", "none");

    var request =  $.ajax({
        url: 'user_login/login.php',
        method: 'POST',
        data: {
            username: $('#username').val(),
            password: $('#password').val()
        },
    });

    request.done(function( msg ) {
        if (msg=="pass"){
            // Login successfull
            window.location.reload(false); 
        }else{
            // Wrong username/password
            wrongLogin.css("display", "block");
        }
      });

    // Must return false to avoid form from submitting
    return false;
}


$("#isAllDay").click(onIsAllDayClicked);

function onIsAllDayClicked(){
    $("#collapseTimeSelect.collapse").collapse('toggle');
}

function onImagePreviewClicked(elem){
    $("#imagebox").attr('src', '');
    $("#imagebox").attr('src', $(elem).prop('value'));
}
