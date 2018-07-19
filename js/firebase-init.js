// Initialize Firebase
const settings = {
    // Fix to giving a deprecation warning
    timestampsInSnapshots: true
};


// Initialize Cloud Firestore through Firebase
firebase.initializeApp(firebase_api);
console.log("FIREBASE-INIT: Initialized firebase");