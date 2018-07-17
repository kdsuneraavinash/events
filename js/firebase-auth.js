function signOut() {
    if (firebase.auth().currentUser) {
        console.log("User logging out");
        firebase.auth().signOut();
    }
    return true;
}

function signIn(email, password, errorDisplay) {
    firebase.auth().signInWithEmailAndPassword(email, password).catch(function (error) {
        errorDisplay.text("Login Failed: " + error.message);
        errorDisplay.css("display", "block");
    });
}

firebase.auth().onAuthStateChanged(function (user) {
    if (user) {
        // User is signed in.
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
            console.log(msg);
            if (msg==="refresh") window.location.reload(false); 
        });
        

    } else {
        // User is signed out.
        // ...
    }
});