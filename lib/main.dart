import 'package:flutter/material.dart';

// Sayfalar
import 'pages/splash/splash_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Buradan başlangıç sayfasını seç
    const Widget startPage = SplashPage(); // <--- Burayı değiştir

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(useMaterial3: false),
      home: startPage,
    );
  }
}
