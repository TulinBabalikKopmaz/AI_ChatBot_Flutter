// Flutter'ın Material Design bileşenlerini içe aktarır.
import 'package:flutter/material.dart';

// Uygulama genelinde kullanılan yardımcı değişkenler ve fonksiyonlar için bir modül.
import '../helper/global.dart';

// CustomBtn adında, özelleştirilmiş bir buton widget'ı oluşturan StatelessWidget sınıfı.
class CustomBtn extends StatelessWidget {
  // Buton üzerinde gösterilecek metin.
  final String text;

  // Butona tıklandığında tetiklenecek fonksiyon.
  final VoidCallback onTap;

  // Constructor: Butonun tıklama fonksiyonunu ve metnini alır.
  const CustomBtn({super.key, required this.onTap, required this.text});

  @override
  Widget build(BuildContext context) {
    return Align(
      // Butonu hizalamak için Align widget'ı.
      child: ElevatedButton(
        // ElevatedButton widget'ının stilini belirlemek için style özelliği.
          style: ElevatedButton.styleFrom(
            // Butona oval bir şekil verir.
              shape: const StadiumBorder(),
              // Gölgeyi kaldırır, düz bir tasarım sağlar.
              elevation: 0,
              // Butonun arka plan rengini mavi olarak ayarlar.
              backgroundColor: Colors.blue,
              // Buton üzerindeki metnin yazı tipi stilini ayarlar.
              textStyle:
              const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              // Butonun minimum genişlik ve yüksekliğini cihaz boyutuna göre ayarlar.
              minimumSize: Size(mq.width * .4, 50)),
          // Buton tıklandığında çağrılacak fonksiyonu tanımlar.
          onPressed: onTap,
          // Buton üzerinde gösterilecek metni içerir.
          child: Text(text)),
    );
  }
}
