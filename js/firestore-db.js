// DEPENDANCY: firebase-app-google
// DEPENDANCY: firebase-store-google
// DEPENDANCY: firebase-init

const firestore = firebase.firestore();
firestore.settings(settings);
console.log("FIREBASE-DB: Firestore initialized");


// Add a record to database
function addRecord(eventData, wrappedFunction) {
    firestore.collection("events").add(eventData)
        .then(function (docRef) {
            console.log("FIREBASE-DB: Document written with ID: ", docRef.id);
            wrappedFunction(docRef);
        })
        .catch(function (error) {
            console.error("FIREBASE-DB: Error adding document: [" + error.code + "] " + error.message);
        });
}

// Show all records
function readAllData(wrappedFunction) {
    console.log("FIREBASE-DB: Record read stream initialized");
    firestore.collection("events").get().then(function (querySnapshot) {
        querySnapshot.forEach(function (doc) {
            // doc.data() is never undefined for query doc snapshots
            console.log("FIREBASE-DB: Document with " + doc.id + " ID read");
            if (wrappedFunction==null) return;
            // Pass doc to inner function
            wrappedFunction(doc);
        });
    }).catch(function (error) {
        console.error("FIREBASE-DB: Error reading document: [" + error.code + "] " + error.message);
    });
}
