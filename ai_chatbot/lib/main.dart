import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

import 'helper/global.dart';
import 'screen/splash_screen.dart';


Future<void> main() async {
  // Flutter'ın widget sistemini başlatır. Asenkron işlemler başlamadan önce çağrılması gerekir.
  WidgetsFlutterBinding.ensureInitialized();

  // Uygulamayı tam ekran moda geçirir. Durum çubuğu ve gezinme çubuğu gizlenir ancak ekran kenarından kaydırılarak yeniden görünebilir.
  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

  // Uygulamanın ekran yönelimini dikey modla sınırlar (portraitUp ve portraitDown).
  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  // Uygulamayı başlatır ve ana widget olarak MyApp'i çalıştırır.
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      // Uygulamanın başlığı. 
      title: appName,

      // Debug modunda sağ üst köşede çıkan "Debug" yazısını gizler.
      debugShowCheckedModeBanner: false,

      // Uygulamanın genel temasını tanımlar.
      theme: ThemeData(
          // Material Design 3 (M3) kullanılmıyor, Material Design 2 (M2) kullanılıyor.
          useMaterial3: false,

          // Uygulamanın AppBar temasını özelleştirir.
          appBarTheme: const AppBarTheme(
            // AppBar'ın gölgelendirme yüksekliği.
            elevation: 1,

            // AppBar başlığını ortalar.
            centerTitle: true,

            // AppBar arka plan rengini beyaz yapar.
            backgroundColor: Colors.white,

            // AppBar'daki ikonların rengini mavi yapar.
            iconTheme: IconThemeData(color: Colors.blue),

            // AppBar başlığının yazı tipini ayarlar.
            titleTextStyle: TextStyle(
                color: Colors.blue, // Yazı rengi mavi.
                fontSize: 20,      // Yazı boyutu 20.
                fontWeight: FontWeight.w500 // Orta kalınlıkta yazı tipi.
            ),
          )),

      // Uygulamanın başlangıç widget'ı (SplashScreen).
      home: const SplashScreen(),
    );
  }
}


