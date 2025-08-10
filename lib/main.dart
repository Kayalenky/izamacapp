import 'package:flutter/material.dart';

// Sayfalar
import 'pages/splash/splash_page.dart';
import 'pages/machineinfo/machine_info.dart';
import 'pages/home/main_page.dart';
import 'pages/productCatalog/product_cat.dart';   // <— BUNU EKLE
import 'pages/services/services.dart';   // <— BUNU EKLE
import 'pages/aboutus/aboutUs.dart';   // <— BUNU EKLE
import 'pages/settings/settings.dart';   // <— BUNU EKLE

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Buradan başlangıç sayfasını seç
    const Widget startPage = SettingsPage(); // <--- Burayı değiştir

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(useMaterial3: false),
      home: startPage,
    );
  }
}
