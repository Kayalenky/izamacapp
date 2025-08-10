import 'package:flutter/material.dart';
import 'package:izamacapp/pages/login/hesapolustur.dart';

class GirisSorunuSayfasi extends StatelessWidget {
  const GirisSorunuSayfasi({super.key});

  // Sabit renkler
  static const Color brandGreen = Color.fromARGB(255, 1, 96, 4);
  static const Color accentGreen = Color.fromARGB(255, 0, 232, 12);
  static const Color cardColor = Color(0xFF1E1E1E);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(screenWidth * 0.06),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // LOGO
                SizedBox(
                  height: screenHeight * 0.12,
                  width: screenWidth * 0.35,
                  child: Center(
                    child: Text(
                      'logo',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: screenWidth * 0.12,
                        shadows: [
                          Shadow(
                          color: Color.fromRGBO(158, 158, 158, 0.5),
                            blurRadius: 10,
                            offset: const Offset(0, 0),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.05),

                // KART
                Container(
                  padding: EdgeInsets.all(screenWidth * 0.06),
                  decoration: BoxDecoration(
                    color: cardColor,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: brandGreen, width: 1),
                  ),
                  child: Column(
                    children: <Widget>[
                      Text(
                        'Giriş Yaparken Sorun mu Yaşıyorsun?',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: screenWidth * 0.05,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      Text(
                        'E-posta adresini, telefon numaranı veya kullanıcı adını gir; hesabına yeniden girebilmen için sana bir bağlantı gönderelim.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: screenWidth * 0.035,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.03),

                      // Girdi
                      TextField(
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'Telefon numarası veya E-posta',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.04,
                            vertical: screenHeight * 0.015,
                          ),
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.02),

                      // Bağlantı gönder
                      ElevatedButton(
                        onPressed: () {

                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          minimumSize: Size(
                            screenWidth * 0.55,
                            screenHeight * 0.06,
                          ),
                        ),
                        child: Text(
                          'Giriş bağlantısı gönder',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: screenWidth * 0.045,
                          ),
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.03),

                      // Ayraç
                      Row(
                        children: <Widget>[
                          const Expanded(child: Divider(color: accentGreen)),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: screenWidth * 0.04,
                            ),
                            child: Text(
                              'Ya da',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: screenWidth * 0.035,
                              ),
                            ),
                          ),
                          const Expanded(child: Divider(color: accentGreen)),
                        ],
                      ),
                      SizedBox(height: screenHeight * 0.03),

                      // Yeni hesap oluştur
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const HesapOlusturSayfasi(),
                            ),
                          );
                        },
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          minimumSize: Size(
                            screenWidth * 0.6,
                            screenHeight * 0.06,
                          ),
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: const BorderSide(color: Colors.white, width: 2),
                          ),
                        ),
                        child: Text(
                          'Yeni hesap oluştur',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: screenWidth * 0.045,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
