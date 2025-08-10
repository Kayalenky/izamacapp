import 'package:flutter/material.dart';
import 'package:izamacapp/pages/login/hesapolustur.dart';
import 'package:izamacapp/pages/login/sifremiunuttum.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

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
                // Üstte çark ikonu
                SizedBox(
                  height: screenHeight * 0.20,
                  width: screenHeight * 0.15,
                  child: const Center(
                    child: Icon(
                      Icons.settings, // çark
                      color: Colors.white,
                      size: 96,
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.05),

                // Kart
                Container(
                  padding: EdgeInsets.all(screenWidth * 0.06),
                  decoration: BoxDecoration(
                    color: cardColor,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: brandGreen, width: 1),
                  ),
                  child: Column(
                    children: <Widget>[
                      // Telefon/E-posta
                      TextField(
                        keyboardType: TextInputType.emailAddress,
                        style: const TextStyle(color: Colors.black), // yazı siyah
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'Telefon numarası ya da eposta',
                          hintStyle: const TextStyle(color: Colors.black), // placeholder siyah
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

                      // Şifre
                      TextField(
                        obscureText: true,
                        style: const TextStyle(color: Colors.black), // yazı siyah
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'şifre',
                          hintStyle: const TextStyle(color: Colors.black), // placeholder siyah
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

                      // Şifremi unuttum → GirisSorunuSayfasi
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const GirisSorunuSayfasi(),
                              ),
                            );
                          },
                          child: Text(
                            'Şifreni mi unuttun?',
                            style: TextStyle(
                              color: accentGreen,
                              fontSize: screenWidth * 0.035,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.01),

                      // Giriş
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          minimumSize:
                              Size(screenWidth * 0.5, screenHeight * 0.06),
                        ),
                        child: Text(
                          'Giriş',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: screenWidth * 0.04,
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

                      // Üye ol
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const HesapOlusturSayfasi(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          minimumSize:
                              Size(screenWidth * 0.5, screenHeight * 0.06),
                        ),
                        child: Text(
                          'Üye ol',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: screenWidth * 0.045,
                          ),
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.02),

                      // Misafir girişi
                      TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          minimumSize:
                              Size(screenWidth * 0.5, screenHeight * 0.06),
                          backgroundColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: const BorderSide(color: Colors.white, width: 1),
                          ),
                        ),
                        child: Text(
                          'Misafir Girişi',
                          style: TextStyle(
                            color: Colors.white,
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
