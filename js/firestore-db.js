const firestore = firebase.firestore();
firestore.settings(settings);

function addRecord(eventData) {
    firestore.collection("events").add(eventData)
        .then(function (docRef) {
            console.log("Document written with ID: ", docRef.id);
        })
        .catch(function (error) {
            console.error("Error adding document: ", error);
        });
}

function viewAllRecords() {
    console.log("Reading all records");
    firestore.collection("events").get().then(function (querySnapshot) {
        querySnapshot.forEach(function (doc) {
            // doc.data() is never undefined for query doc snapshots
            console.log(doc.id, " => ", doc.data());
        });
    });
    console.log("All records read");
}
