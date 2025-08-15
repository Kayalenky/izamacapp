// Firebase SDK'larını import et
importScripts("https://www.gstatic.com/firebasejs/9.23.0/firebase-app-compat.js");
importScripts("https://www.gstatic.com/firebasejs/9.23.0/firebase-messaging-compat.js");

// BURAYA KENDİ FIREBASE PROJE BİLGİLERİNİ GİR
const firebaseConfig = {
    apiKey: 'AIzaSyCH3XOIM9FJNv6rxtAsRn1haKmW_Y_RGmg',
    appId: '1:1097750035726:web:bd3f66f902342fe485eb5f',
    messagingSenderId: '1097750035726',
    projectId: 'geridonusum-52c78',
    authDomain: 'geridonusum-52c78.firebaseapp.com',
    storageBucket: 'geridonusum-52c78.firebasestorage.app',
    measurementId: 'G-MSY3E9TW9W',
};

// Firebase'i başlat
firebase.initializeApp(firebaseConfig);

// Arka plan mesajlarını handle edecek messaging servisini al
const messaging = firebase.messaging();

// İsteğe bağlı: Arka plan bildirimlerini dinlemek için
messaging.onBackgroundMessage(function(payload) {
  console.log('Arka planda bildirim alındı: ', payload);
  // Burada gelen bildirime göre özel işlemler yapabilirsin.
  const notificationTitle = payload.notification.title;
  const notificationOptions = {
    body: payload.notification.body,
    icon: '/favicon.png' // `web` klasöründeki bir ikonu gösterebilirsin
  };

  self.registration.showNotification(notificationTitle, notificationOptions);
});