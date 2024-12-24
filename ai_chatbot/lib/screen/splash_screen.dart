import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../helper/global.dart';
import '../widget/custom_loading.dart';
import 'home_screen.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    
    Future.delayed(const Duration(seconds: 3), () {

      //  Navigator.of(context).pushReplacement(
      //  MaterialPageRoute(builder: (_)=> const HomeScreen()));

      Get.off(() => const HomeScreen());
    });

    // Bir süre bu ekranda bekledikten sonra home screen geçicek.
    // 3 saniye olarak ayarlandı.
    // Getx paketi sayesinde navigatör kısmını daha kısa yazmamızı sağladık.
    // Getx paketi ile kolay durum yönetimi yapabildik.

  // initState(): Widget ilk oluşturulduğunda çalıştırılan bir metottur.
  // Future.delayed: Belirli bir süre gecikme sağlar.
  // Duration(seconds: 3) ile 3 saniyelik bir bekleme ayarlanmış.
  // Navigator.of(context): Sayfalar arasında geçiş yapmayı sağlar.
  // pushReplacement: Şu anki sayfayı (Splash Screen) yeni sayfa (HomeScreen) ile değiştirir. Yani, Splash Screen geçmişe eklenmez ve geri tuşuna basıldığında tekrar gösterilmez.
  // MaterialPageRoute: Yeni bir sayfa (HomeScreen) oluşturur.
  // const HomeScreen(): Hedef sayfaya git. 

  // Uygulama açıldığında 2 saniyelik bir bekleme sağlanır.
  // Ardından, Splash Screen yerine Home Screen gösterilir.
  }

  @override
  Widget build(BuildContext context) {
    
    mq = MediaQuery.sizeOf(context); 
    // mq değişkenine ekran boyutlarını atıyor. 
    // Tüm ekranlara uyum sağlaması açısından böyle bişi yaptık 
    // global.dart kısmında tanımlandı bu değişken

    return Scaffold(
      
      body: SizedBox(
        width: double.maxFinite,
        child: Column(
          children: [
           
            // Columunda Boşluk oluşturduk. Ama ötekilere kıyasla 2 birim daha geniş.
            const Spacer(flex: 2),

            // İlk açılış ekranındaki logoyu ayarlamak için Card oluşturduk.
            Card(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: Padding(
                padding: EdgeInsets.all(mq.width *(0.05)),
                child: Image.asset(
                  'assets/images/logo.png',
                  width: mq.width *(0.4),
                ),
              ),
            ),

            
            const Spacer(), // Columunda Boşluk oluşturduk
            
            const CustomLoading(), // İlk açılış ekranındaki animasyonu eklemek için oluşturduk.
  
            const Spacer(),// Columunda Boşluk oluşturduk
            
          ],
        ),
      ),
    );

// SplashScreen ekranı oluşturmak için yazılmış. Kullanıcı uygulamayı ilk açığında logoyu görücek.
// State<SplashScreen> kısmı, bu sınıfın SplashScreen adındaki StatefulWidget ile ilişkili olduğunu ifade eder.
// _SplashScreenState özel (private) bir sınıftır; başındaki _ ile sadece bu dosyada erişilebileceği belirtilmiş.
// Bu metod, widget ağacını (widget tree) oluşturur ve her durum değişikliğinde yeniden çağrılır.
// context parametresi, widget'ın bulunduğu ortam hakkında bilgi sağlar (ör. tema, ekran boyutları).

// Scaffold, Flutter'da bir sayfanın temel düzenini sağlar.
      // body: body alanında bir SizedBox kullanılarak tam genişlikte bir düzen oluşturuldu.
// SizedBox:
      // width: double.maxFinite: Elemanın genişliği ekranın tamamını kapsar.
// Column: Birden fazla widget'ı dikey olarak hizalar.
      // İlk olarak boş bir alan (Spacer(flex: 2)).
      // Ortada bir kart tasarımı (Card) ve logo resmi (Image.asset).
      // Daha sonra bir yükleme animasyonu (CustomLoading).
      // Altında yine bir boş alan (Spacer).
// Card: Card widget'ı yuvarlatılmış köşeler ve iç dolgu ile logo resmi içerir.
      // RoundedRectangleBorder: Radius.circular(20): Kartın köşelerini 20 birim yuvarlar.
      // Padding: Dinamik olarak ayarlanmış (mq.width * 0.05): Kart ekran genişliğinin %5'i kadar bir dolguya sahip.
      // Image.asset: Logo dosyasını (assets/images/logo.png) gösterir.
      // Resmin genişliği dinamik olarak ekranın %40'ına (mq.width * 0.4) ayarlanmış.
// CustomLoading: Yükleme animasyonu için oluşturduğumuz widget çağirir.
  }
}

// Bu ekran sadece açılış ekranıdır. Belirli bir süre durup ana ekrana geçmelidir.
// Ana ekran home_screen.dart yazılmıştır.
