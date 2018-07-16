// Initialize Firebase
const config = {
    apiKey: "AIzaSyD9TAf722GkcYr9DeCQym2n9j7N8LflpNg",
    authDomain: "mora-events-database-teamaxys.firebaseapp.com",
    databaseURL: "https://mora-events-database-teamaxys.firebaseio.com",
    projectId: "mora-events-database-teamaxys",
    storageBucket: "",
    messagingSenderId: "517052158638"
};
  
const settings = {
    timestampsInSnapshots: true
};
  

// Initialize Cloud Firestore through Firebase
firebase.initializeApp(config);
const firestore = firebase.firestore();
firestore.settings(settings);

function addRecord(eventData){
    firestore.collection("events").add(eventData)
    .then(function(docRef) {
        console.log("Document written with ID: ", docRef.id);
    })
    .catch(function(error) {
        console.error("Error adding document: ", error);
    });
}

function viewAllRecords(){
    console.log("Reading all records");
    firestore.collection("events").get().then(function(querySnapshot) {
        querySnapshot.forEach(function(doc) {
            // doc.data() is never undefined for query doc snapshots
            console.log(doc.id, " => ", doc.data());
        });
    });
    console.log("All records read");
}
