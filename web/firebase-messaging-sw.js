importScripts("https://www.gstatic.com/firebasejs/8.10.0/firebase-app.js");
importScripts("https://www.gstatic.com/firebasejs/8.10.0/firebase-messaging.js");

const firebaseConfig = {
  apiKey: "AIzaSyAzvRUUfl7-8tObQkzgtqPp7a870EJ_I_U",
  authDomain: "betticos.firebaseapp.com",
  projectId: "betticos",
  storageBucket: "betticos.appspot.com",
  messagingSenderId: "356955805793",
  appId: "1:356955805793:web:56a09c92dac8827a32f220"
};

firebase.initializeApp(firebaseConfig);

const messaging = firebase.messaging();

messaging.onBackgroundMessage(function(payload) {
  const notificationTitle = payload.notification.title;
  const notificationOptions = {
    body: payload.notification.body,
  };

  self.registration.showNotification(notificationTitle,
    notificationOptions);
});