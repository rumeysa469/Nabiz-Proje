import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart'; // Firebase yapılandırma dosyası
import 'home_page.dart'; // Ana sayfa dosyası

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Flutter ile Firebase'i başlatmak için gerekli
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform, // Firebase yapılandırma bilgileri
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Debug banner'ı kaldırır
      title: 'Nabız Ölçer',
      theme: ThemeData(
        primarySwatch: Colors.blue, // Tema rengi olarak mavi seçildi
      ),
      home: const HomePage(), // Ana ekran olarak `HomePage` belirleniyor
    );
  }
}
