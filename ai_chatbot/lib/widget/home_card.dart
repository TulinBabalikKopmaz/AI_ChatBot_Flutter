import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lottie/lottie.dart';

import '../helper/global.dart';
import '../model/home_type.dart';

class HomeCard extends StatelessWidget {

  // HomeType türünde bir parametre alıyor.
  // Bu sayede home_type daki enumdan yararlana biliriz.
  final HomeType homeType;

  // Constructor, homeType değişkenini zorunlu olarak alıyor.
  const HomeCard({super.key, required this.homeType});

  // Home sayfasında yer alan kartlardaki şekilsel özellikleri tanımlıyor.
  @override
      Widget build(BuildContext context) {

        // Hot reload sırasında animasyonların yeniden başlamasını sağlıyor.
        Animate.restartOnHotReload = true;

        return Card( // Kart widget'ı, uygulama içinde bir içerik göstermek için kullanılıyor.

          color: Colors.blue.withOpacity(0.2), // Kartın arka plan rengi mavi ve opaklığı %20 (şeffaflık seviyesi).

          elevation: 0, // Kartın yüksekliği sıfır, yani gölge efekti yok.

          margin: EdgeInsets.only(bottom: mq.height * (0.02)), // Kartın alt kenarından, cihazın ekran yüksekliğinin %2'si kadar boşluk bırakılıyor.

          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ), // Kartın kenarları yuvarlatılmış bir şekil alıyor (20 piksel yarıçap).

          child: InkWell( // Kart tıklanabilir hale getiriliyor.
            //borderRadius: const BorderRadius.all(Radius.circular(20)), // Tıklama efektinde de kenarların yuvarlatılmış olması sağlanıyor.
            onTap: () {Future.delayed(Duration(milliseconds: 600), () {homeType.onTap(); // Tıklama işlemi gecikmeli başlatılıyor. Anımasyon belli olsun diye
            });}, // Kart tıklandığında çalışacak fonksiyon.
            splashColor: Colors.grey.withOpacity(0.5),  // Tıklama efekti için renk belirleniyor.
            highlightColor: Colors.grey.withOpacity(0.3),  // Tıklama esnasında arka planda görünen renk.

            child: homeType.leftAlign // Eğer "leftAlign" true ise, içeriği sola hizala
                ? Row( // Yatay bir düzen oluşturuluyor.
                    children: [  
                      Container( // Lottie animasyonu için bir konteyner:
                        width: mq.width * .4, // Konteynerin genişliği ekran genişliğinin %40'ı.
                        padding: homeType.padding, // Belirtilen dolgu (padding) ekleniyor.
                        child: Lottie.asset('assets/lottie/${homeType.lottie}'), // Lottie animasyonu belirtilen dosyadan yükleniyor.
                      ),

                      const Spacer(), // Boşluk eklemek için Spacer kullanılıyor.

                      Text( // Başlık metni:
                        homeType.title, // HomeType sınıfındaki başlık (title) metni gösteriliyor.

                        style: const TextStyle(
                          fontSize: 20, // Yazı boyutu 20.
                          fontWeight: FontWeight.w500, // Yazı kalınlığı orta (500).
                          letterSpacing: 1, // Harfler arasında 1 birim boşluk.
                        ),
                      ),

                      const Spacer(flex: 2), // Daha geniş bir boşluk eklemek için Spacer'a esneklik veriliyor (flex: 2).
                    ],
                  )
                
                : Row( // Yatay bir düzen oluşturuluyor.

                    children: [ // Eğer "leftAlign" false ise, içeriği sağa hizala: Bişi yazmayında default alır.
                      const Spacer(flex: 2), // Daha geniş bir boşluk (flex: 2) ekleniyor.

                      Text( // Başlık metni:
                        homeType.title, // HomeType sınıfındaki başlık (title) metni gösteriliyor.

                        style: const TextStyle(
                          fontSize: 20, // Yazı boyutu 20.
                          fontWeight: FontWeight.w500, // Yazı kalınlığı orta (500).
                          letterSpacing: 1, // Harfler arasında 1 birim boşluk.
                        ),
                      ),

                      const Spacer(), // Standart bir boşluk ekleniyor. 

                      Container( // Lottie animasyonu için bir konteyner:
                        width: mq.width * .4, // Konteynerin genişliği ekran genişliğinin %40'ı.
                        padding: homeType.padding, // Belirtilen dolgu (padding) ekleniyor.
                        child: Lottie.asset('assets/lottie/${homeType.lottie}'), // Lottie animasyonu belirtilen dosyadan yükleniyor.
                      ),
                    ],
                  ),
          )
        )
        .animate() // Kart widget'ına bir animasyon ekleniyor. Kartalar uzaktan geliyormuş gibi gözüküyor.
        .scale( // Ölçekleme animasyonu:
          duration: 1.seconds,  // Animasyonun süresi 1 saniye.
          curve: Curves.easeIn, // Animasyonun eğrisi "easeIn" (yavaş başlayıp hızlanma).
        );
      }

}
