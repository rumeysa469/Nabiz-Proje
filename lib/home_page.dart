import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final DatabaseReference controlRef = FirebaseDatabase.instance.ref("control");
  final DatabaseReference heartRateRef = FirebaseDatabase.instance.ref("heart_rate");
  int? pulseValue;

  @override
  void initState() {
    super.initState();
    listenToPulseData(); // Firebase'den sürekli veri almak için dinleme başlatılıyor
  }

  void startSensor() async {
    try {
      await controlRef.set(true);
      print("Sensör çalıştırıldı: control=true");
    } catch (e) {
      print("Sensör başlatılamadı: $e");
    }
  }

  void listenToPulseData() {
    heartRateRef.onValue.listen((event) {
      final value = event.snapshot.value;
      if (value != null) {
        setState(() {
          pulseValue = int.tryParse(value.toString()) ?? 0;
        });
        print("Sürekli nabız değeri alındı: $pulseValue");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE3F2FD), // Açık mavi arka plan
      appBar: AppBar(
        title: const Text('Gerçek Zamanlı Nabız Ölçer'),
        centerTitle: true,
        backgroundColor: const Color(0xFF64B5F6), // Açık mavi AppBar
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Beyaz Kalp İkonu ve Açık Mavi Daire
            Container(
              height: 180,
              width: 180,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFFBBDEFB), // Açık mavi daire rengi
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 10,
                    spreadRadius: 2,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Center(
                child: Icon(
                  Icons.favorite, // Kalp simgesi
                  color: Colors.white, // Beyaz dolgulu kalp
                  size: 120,
                ),
              ),
            ),
            const SizedBox(height: 30),

            // Nabız Değeri
            if (pulseValue != null)
              Text(
                "$pulseValue BPM",
                style: const TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1976D2), // Daha koyu mavi metin rengi
                ),
              )
            else
              const Text(
                "Nabız verisi alınamadı.",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontStyle: FontStyle.italic,
                ),
              ),

            const SizedBox(height: 50),

            // "Başla" Butonu
            ElevatedButton(
              onPressed: () {
                startSensor(); // Sensörü başlat
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF64B5F6), // Buton rengi açık mavi
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20), // Yuvarlatılmış köşeler
                ),
              ),
              child: const Text(
                'Başla',
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
