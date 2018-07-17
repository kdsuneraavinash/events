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
