# Mora Events Site

Mora Events Site is a site created in order to add and view events, specially events in University of Moratuwa. This site has a parallel app.
This app and site is created by Team Axys.

## Screenshots

![Index Page](/readme/ss_index.png)

Index page has some placeholder text and containers that we intend to fill later.

------

![Events Page](/readme/ss_events.png)

Shows currently present events. (All events. Will implement querying  later.)

------

![About Page](/readme/ss_showevent.png)

![About Page](/readme/ss_showevent2.png)

Shows currently selected event details.

------

![About Page](/readme/ss_addevent.png)

Form to add events to the database. Anyone can see this, but only those who have logged in can submit. Form is validated before submitting.

------

![About Page](/readme/ss_about.png)

About us and contact our team

## Responsive Websites

We target most user with mobile phones so we needed our website to be responsive. So [Bootstrap 4](https://getbootstrap.com/docs/4.0) is used to do that.

## External Stylesheets

| Stylesheet Name | Usage                                             | Stylesheet                      |
| --------------- | ------------------------------------------------- | ------------------------------- |
| Bootstrap 4     | Used in majority of site to make pages responsive | bootstrap.min.css               |
| Font Awesome    | To include icons in our site                      | fontawesome.css  and  solid.css |

## External Scripts

| Script Name       | Usage                                               | Script                                                       |
| ----------------- | --------------------------------------------------- | ------------------------------------------------------------ |
| jQuery            | To use JavaScript easily                            | jquery-3.3.1.min.js                                          |
| Firebase Services | Authorization and Storing all data                  | firebase-app.js,  firebase-auth.js and  firebase-firestore.js |
| Bootstrap         | Making pages responsive and developing pages faster | popper.min.js and  bootstrap.min.js                          |
| Cloudinary        | Cloudinary Image upload widget                      | all.js                                                       |

## Adding an event

When adding an event the sequence of events is,

1. Checked if user is logged in, if not terminate.
2. Validate form data.
3. Make a `POST` to `post.php` with form information. This page will show a loading screen and send data to Firebase Firestore to be written to the database.
4. Once that operation is succeeded user is redirected to `showevent.php` with a `GET` request to show the event.

## Showing an Event

This is done by `showevent.php` and is separated from rest of website. Design used is also different and this is the only page which uses a custom header (as opposed to other pages including `header.php`) This page shows a event when it receives a get request with eventid. `*showevent.php?eventid=52WKamujiDM0ZNuMYhqm*` will show event with id `52WKamujiDM0ZNuMYhqm`. This uses a separate request from Firestore and this will cause the page to reload data already loaded in events.php and this needs to be fixed.

## Security

> Since this website does not include any sensitive data security is not a huge concern.

User authorization is done by Firebase by `javaScript`. For the sake of testing we made Server to store Session information of users when logged in. Process is done as following.

### User is not logged in

**In this process data is sent to `user_login/logout.php` as a `POST` without any actually including any information.**

Once Firebase-Auth initializes it will fire `onAuthStateChanged` event. Since user is not logged in it will identify user as Signed Out.

Since user is not logged in, `javaScript` then sends a signal back to the server with `AJAX`. Server then checks `_SESSION` variables. If it indicates user is not logged in (expecting result), it returns with `session-not-present`. Authorization process ends here.

However for some reason `_SESSION` indicates user is logged in (unexpecting) , server will delete session information and return `session-deleted-refresh`  message. Then `javaScript` will refresh the page. (Since server thought that the user was logged in when it sent the page, page layout might be different from what should be shown)

Once the page refreshes, it will then again start the process. However now the server will certainly return `session-not-present`. So Authorization is ended.

### User logs in

`javaScript` will sign in using email and password given. If it succeeds, user will be registered as logged in Firebase Auth, which triggers a `onAuthStateChanged` event.  *See under User is logged in.*

### User is logged in

**In this process user information is sent to `user_login/login.php` as a `POST`.**

This will fire a `onAuthStateChanged` event and `javaScript` will send email, uid and display name (not implemented yet).

Server will then check whether these info is  already present in `_SESSION`. If present it means user was already signed in. This will not happen if user just logged in. But when user refreshes a page when logged in, this will happen. If this happens server will send `session-already-set` message. Authorization process ends here.

However `_SESSION` does not contain this info **OR** uid in `_SESSION` is different from uid sent, then Server will create add new data to `_SESSION` and send `session-set-refresh` message. `javaScript` will refresh the page and this who;e process happens again. But now Server will return `session-already-set` message so Authorization will end here.

**This process might be flawed, please inform if change needs to happen.** This was just a process I thought of so this would certainly be flawed. So feedback on this regard is highly appreciated.

## Storing Images

Since we ask users to include images when creating a event, we have to store these images. We use [Cloudinary](https://cloudinary.com) services in order to do this. Currently `kdsuneraavinash` account is used, but we hope to move it into another account later. We also use [Cloudinary Upload Widget 2.0 (beta)](https://cloudinary.com/documentation/upload_widget_2) to help users to upload images.

## Firebase Integration

[Firebase](https://firebase.google.com) Firestore and Firebase Auth was largely used in this project.

Each event would be stored in the Firestore in a Document named `events`.  Currently `mora-events-database-teamaxys` database is used to store data.  *API Keys are not included in this repository*. Document security is,

```javascript
service cloud.firestore {
  match /databases/{database}/documents {
    match /{document=**} {
      allow write: if request.auth.uid != null;
      allow read: if true;
    }
  }
}
```

Anyone can read data but to write data, user must be signed in. **However these rules are used only in development and will be tightened afterwards.**

Authorization is done by Firebase-Auth and accounts are created by teamaxys. **Website does not allow creating accounts.** Instead users are encouraged to send email to teamaxys to create a website for them. The reason is that all accounts have to verified accounts or someone can spam this website and app. When authorizing this does not store any additional information on users. Only `uid`, `email` and `password` is stored.  

## Developer Console

Console logs are created whenever an important action is performed. (eg: Firebase connecting, Server signals)

- `FIREBASE-APP` : Starting firebase API
- `FIREBASE-DB` : Firebase Firestore database
- `FIREBASE-AUTH` : Firebase Authorization

## Testing

Visit [Test Site](https://kdsuneraavinash.000webhostapp.com) in order to view last uploaded version.

## Team Axys Members

- Sunera Avinash
- Deepana Ishtaweera
- Dinith Herath
- Ruchin Amarathunga
- Uvindu Avishka
- Ravikula Silva

![Axys Logo](/readme/axys_logo.jpg)
