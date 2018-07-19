// Initialize Firebase
const settings = {
    // Fix to giving a deprecation warning
    timestampsInSnapshots: true
};
// Initialize Cloud Firestore through Firebase
firebase.initializeApp(firebase_api);
console.log("FIREBASE-APP: Initialized firebase");

const firebase_auth = firebase.auth();
console.log("FIREBASE-AUTH: Initialized Firebase auth");
const firestore = firebase.firestore();
firestore.settings(settings);
console.log("FIREBASE-DB: initialized Firestore");
