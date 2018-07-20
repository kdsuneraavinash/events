// Add a record to database
function addRecord(eventData, wrappedFunction, wrappedErrorFunction) {
    firestore.collection("events").add(eventData)
        .then(function (docRef) {
            console.log("FIREBASE-DB: Document written with ID ", docRef.id);
            if (wrappedFunction == null) return;
            // Pass doc to inner function
            wrappedFunction(docRef);
        })
        .catch(function (error) {
            console.error("FIREBASE-DB: Error adding document [" + error.code + "] " + error.message);
            if (wrappedErrorFunction == null) defaultFirestoreErrorHandler();
            else wrappedErrorFunction();
        });
}

// Show all records
function readAllData(wrappedReadOneDocumentFunction, wrappedDoneFunction, wrappedErrorFunction) {
    console.log("FIREBASE-DB: Record read stream initialized");
    firestore.collection("events").get().then(function (querySnapshot) {
        querySnapshot.forEach(function (doc) {
            // doc.data() is never undefined for query doc snapshots
            console.log("FIREBASE-DB: Document with " + doc.id + " ID read");
            if (wrappedReadOneDocumentFunction == null) return;
            // Pass doc to inner function
            wrappedReadOneDocumentFunction(doc);
        });
        if (wrappedDoneFunction == null) return;
        wrappedDoneFunction();
    }).catch(function (error) {
        console.error("FIREBASE-DB: Error reading document [" + error.code + "] " + error.message);
        if (wrappedErrorFunction == null) defaultFirestoreErrorHandler();
        else wrappedErrorFunction();
    });

}

function readDocument(docID, wrappedExistFunction, wrappedNotExistFunction, wrappedErrorFunction) {
    console.log("FIREBASE-DB: Loading document with ID: " + docID);
    var docRef = firestore.collection("events").doc(docID);
    docRef.get().then(function (doc) {
        if (doc.exists) {
            console.log("FIREBASE-DB: Document ID " + doc.id + " read");
            if (wrappedExistFunction == null) return;
            // Pass doc to inner function
            wrappedExistFunction(doc);
        } else {
            console.log("FIREBASE-DB: No such document " + doc.id);
            if (wrappedNotExistFunction == null) return;
            wrappedNotExistFunction();
            // doc.data() will be undefined in this case
        }
    }).catch(function (error) {
        console.log("FIREBASE-DB: Error getting document: ", error);
        if (wrappedErrorFunction == null) defaultFirestoreErrorHandler();
        else wrappedErrorFunction();
    });
}

function defaultFirestoreErrorHandler(){
    alert("Sorry but we couldn't retrieve needed information from the server. Unstable network connection might be the reason.\n" + 
        "Please check your network connection\n" + 
        "We will now redirect you to the Home page");
        window.location.href = 'index.php';
}