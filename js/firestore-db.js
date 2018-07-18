const firestore = firebase.firestore();
firestore.settings(settings);
console.log("Firestore initialized");

// Add a record to database
function addRecord(eventData) {
    firestore.collection("events").add(eventData)
        .then(function (docRef) {
            console.log("Document written with ID: ", docRef.id);
        })
        .catch(function (error) {
            console.error("Error adding document: ", error);
        });
}

// Show all records
function readAllData(wrappedFunction) {
    console.log("Record read stream initialized");
    firestore.collection("events").get().then(function (querySnapshot) {
        querySnapshot.forEach(function (doc) {
            // doc.data() is never undefined for query doc snapshots
            console.log("Document with " + doc.id + " ID read");
            if (wrappedFunction==null) return;
            // Pass doc to inner function
            wrappedFunction(doc);
        });
    }).catch(function (error) {
        console.error("Error adding document: ", error);
    });
}