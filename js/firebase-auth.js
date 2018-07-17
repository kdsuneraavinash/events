function signOut() {
    console.log("User Firebase Signing out process started");
    if (firebase.auth().currentUser) {
        console.log("Logged user detected. Signing out from firebase.");
        firebase.auth().signOut();
        console.log("User signed out from firebase");
    }
}

function signIn(email, password, errorDisplay) {
    firebase.auth().signInWithEmailAndPassword(email, password).catch(function (error) {
        errorDisplay.text("Login Failed: " + error.message);
        errorDisplay.css("display", "block");
        console.log("Firebase Login failed: [" + error.code + "] " + error.message);
    });
}

firebase.auth().onAuthStateChanged(function (user) {
    console.log("Firebase login state change detected");
    if (user) {
        // User is signed in.
        console.log("An user is already signed in");
        console.log("Sending AJAX to store session");
        var request = $.ajax({
            url: 'user_login/login.php',
            method: 'POST',
            data: {
                email: user.email,
                displayName: user.displayName,
                photoURL: user.photoURL,
                uid: user.uid,
            },
        });
        request.done(function (msg) {
            console.log("AJAX login returns: " + msg);
            if (msg==="refresh") window.location.reload(false); 
        });
    } else {
        console.log("No signed in user");
        console.log("Sending AJAX to delete session");
        var request = $.ajax({
            url: 'user_login/logout.php',
            method: 'POST',
            data: {},
        });
        request.done(function (msg) {
            console.log("AJAX logout returns: " + msg);
            if (msg==="refresh") window.location.reload(false); 
        });
    }
});