import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User? get currentUser => _auth.currentUser;

  String _getTurkishErrorMessage(String code) {
    switch (code) {
      case 'user-not-found':
        return 'Bu e-posta adresi ile kayıtlı bir kullanıcı bulunamadı.';
      case 'wrong-password':
        return 'Girdiğiniz şifre yanlış. Lütfen tekrar deneyin.';
      case 'invalid-email':
        return 'Geçersiz bir e-posta adresi girdiniz.';
      case 'email-already-in-use':
        return 'Bu e-posta adresi zaten başka bir hesap tarafından kullanılıyor.';
      case 'weak-password':
        return 'Şifreniz çok zayıf. Lütfen en az 6 karakterli daha güçlü bir şifre seçin.';
      case 'invalid-credential':
        return 'E-posta veya şifre hatalı. Lütfen bilgilerinizi kontrol edin.';
      case 'too-many-requests':
        return 'Çok fazla deneme yapıldı. Lütfen daha sonra tekrar deneyin.';
      default:
        return 'Beklenmedik bir hata oluştu. Lütfen tekrar deneyin.';
    }
  }

  Future<UserCredential> signInWithEmailPassword(
      String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(_getTurkishErrorMessage(e.code));
    }
  }

  Future<UserCredential> createUserWithEmailPassword({
    required String email,
    required String password,
    required String adSoyad,
    required DateTime dogumGunu,
  }) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = userCredential.user;

      if (user != null) {
        await _firestore.collection('users').doc(user.uid).set({
          'adSoyad': adSoyad,
          'dogumGunu': Timestamp.fromDate(dogumGunu),
          'email': email,
          'machines': [],
          'rol': 'yeni',
          'uid': user.uid,
          'dogumGunuAy': dogumGunu.month,
          'dogumGunuGun': dogumGunu.day,
        });

        await user.sendEmailVerification();
      }

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(_getTurkishErrorMessage(e.code));
    }
  }

  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw Exception(_getTurkishErrorMessage(e.code));
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
