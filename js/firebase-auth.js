// DEPENDANCY: JQuery
// DEPENDANCY: firebase-app-google
// DEPENDANCY: firebase-auth-google
// DEPENDANCY: firebase-init

const firebase_auth = firebase.auth();

// Sign out an user
function signOut() {
    if (firebase_auth.currentUser) {
        firebase_auth.signOut();
    }
    console.log("FIREBASE-AUTH: User signed out from firebase");
    sendSignOutAjax();
}


// Sign in using email and password
function signIn(email, password) {
    firebase_auth.signInWithEmailAndPassword(email, password).catch(function (error) {
        signInErrorHandler(error);
        console.error("FIREBASE-AUTH: Firebase Login failed: [" + error.code + "] " + error.message);
    });
}


// FIXME: Modify the function calling this
function signInErrorHandler(error) {
    // TODO: Add what to do when sign error
    // TODO: Ad switch statement to handle error codes
    var errorDisplay = $("#wrong_login")
    errorDisplay.text("Login Failed: " + error.message);
    errorDisplay.css("display", "block");
    $("#user_login_image").css(playState, 'paused');
}


// On sign In state changed notify server to store _SESSION
firebase.auth().onAuthStateChanged(function (user) {
    if (user) {
        // User is signed in.
        console.log("FIREBASE-AUTH: User signed in.");
        sendSignInAjax({
            email: user.email,
            displayName: user.displayName,
            uid: user.uid,
        },);
    } else {
        console.log("FIREBASE-AUTH: User not signed in");
        sendSignOutAjax();
    }
});


function sendSignInAjax(data) {
    console.log("FIREBASE-AUTH: Sending AJAX to store session.");
    // Then info that user is signed in is sent over AJAX to PHP
    var request = $.ajax({
        url: 'user_login/login.php',
        method: 'POST',
        data: data,
    });
    request.done(function (msg) {
        // If return refresh it means PHP didn't know user was signed in
        // So it has to fix itself
        console.log("FIREBASE-AUTH: AJAX login returns: " + msg);
        if (msg === "session-set-refresh") window.location.reload(false);
    });
}


function sendSignOutAjax(){
    console.log("FIREBASE-AUTH: Sending AJAX to delete session");
    // Then message that user is signed out is sent over AJAX to PHP
    var request = $.ajax({
        url: 'user_login/logout.php',
        method: 'POST',
        data: {},
    });
    request.done(function (msg) {
        // If return refresh it means PHP didn't know user was  not signed in
        // So it has to fix itself
        console.log("FIREBASE-AUTH: AJAX logout returns: " + msg);
        if (msg === "session-deleted-refresh") document.location = "index.php";
    });
}