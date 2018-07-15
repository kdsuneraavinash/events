function onLoginButtonClicked(){
    var wrongLogin = $("#wrong_login");
    wrongLogin.css("display", "none");

    var request =  $.ajax({
        url: 'post/login.php',
        method: 'POST',
        data: {
            username: $('#username').val(),
            password: $('#password').val()
        },
    });

    request.done(function( msg ) {
        if (msg=="pass"){
            window.location.reload(false); 
        }else{
            wrongLogin.css("display", "block");
        }
      });

    return false;
}