import * as functions from "firebase-functions/v1";
import * as admin from "firebase-admin";


admin.initializeApp();

const db = admin.firestore();
const messaging = admin.messaging();

export const dogumGunuBildirimiGonder = functions.pubsub
  .schedule("every day 09:00")
  .timeZone("Europe/Istanbul")
  .onRun(async (_context) => {
    const today = new Date();
    const currentMonth = today.getMonth() + 1;
    const currentDay = today.getDate();

    functions.logger.log(
      `Fonksiyon çalıştı. Bugün: ${currentDay}/${currentMonth}`,
    );

    const snapshot = await db
      .collection("users")
      .where("dogumGunuAy", "==", currentMonth)
      .where("dogumGunuGun", "==", currentDay)
      .get();

    if (snapshot.empty) {
      functions.logger.log("Bugün doğum günü olan kullanıcı bulunamadı.");
      return null;
    }

    const notificationPromises: Promise<admin.messaging.MessagingDevicesResponse>[] = [];

    snapshot.forEach((doc) => {
      const user = doc.data();
      const token = user.fcmToken;

      if (token) {
        const payload: admin.messaging.MessagingPayload = {
          notification: {
            title: "🎉 Doğum Günün Kutlu Olsun! 🎂",
            body:
              `${user.adSoyad}, harika bir gün ve mutlu bir yeni yaş dileriz!`,
            clickAction: "FLUTTER_NOTIFICATION_CLICK",
          },
        };

        functions.logger.log(
          `${user.adSoyad} (${doc.id}) adlı kullanıcıya bildirim gönderiliyor.`,
        );
        notificationPromises.push(messaging.sendToDevice(token, payload));
      }
    });

    await Promise.all(notificationPromises);

    return null;
  });