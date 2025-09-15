// web/firebase-messaging-sw.js

importScripts("https://www.gstatic.com/firebasejs/9.0.0/firebase-app-compat.js");
importScripts("https://www.gstatic.com/firebasejs/9.0.0/firebase-messaging-compat.js");

firebase.initializeApp({
   apiKey: "AIzaSyCgU86zhROKrnwVBVbGsj5H3zOpRFsrL7k",
   authDomain: "draw-d1fac.firebaseapp.com",
   databaseURL: "https://draw-d1fac-default-rtdb.firebaseio.com",
   projectId: "draw-d1fac",
   storageBucket: "draw-d1fac.firebasestorage.app",
   messagingSenderId: "217855941783",
   appId: "1:217855941783:web:67b128ddb96905ede81dd2",
   measurementId: "G-79ZGMDEMGW"
});

const messaging = firebase.messaging();

// Lắng nghe tin nhắn background
messaging.onBackgroundMessage((payload) => {
  console.log("Background message received:", payload);
  self.registration.showNotification(payload.notification.title, {
    body: payload.notification.body,
    icon: "/icons/Icon-192.png",
  });
});
