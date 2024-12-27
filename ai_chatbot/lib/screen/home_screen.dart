import 'package:flutter/material.dart'; // Flutter'ın temel UI bileşenlerini kullanmak için gerekli.
import 'package:flutter/services.dart'; // Sistem özelliklerini kontrol etmek ve değiştirmek için gerekli.

import '../helper/global.dart'; // Global değişkenler ve metotların bulunduğu dosya.
import '../model/home_type.dart'; // HomeType enum'unu içeren dosya.
import '../widget/home_card.dart'; // HomeCard adlı özel widget'ı içeren dosya.

// HomeScreen adında bir StatefulWidget sınıfı oluşturuluyor.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key}); // StatefulWidget için bir constructor oluşturulmuş ve key değeri atanmış.

  @override
  State<HomeScreen> createState() => _HomeScreenState(); // Bu widget'ın durumunu yönetecek olan sınıfı (_HomeScreenState) döndürüyor.
}

// HomeScreen widget'ının durumunu yöneten sınıf.
class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() { // Widget ilk defa oluşturulduğunda çalışan metot.
    super.initState(); // StatefulWidget'ın varsayılan initState davranışını çağırır.

    // Sistem UI modunu edge-to-edge olarak ayarlıyor. Bu, içeriğin cihazın kenarlarına kadar genişletilmesini sağlar.
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  }

  @override
  Widget build(BuildContext context) { // Widget ağacını oluşturan metot.
    // MediaQuery ile cihaz boyutlarını alıyor ve global bir değişkene atıyor.
    mq = MediaQuery.sizeOf(context);

    // Scaffold widget'ı sayfanın temel yapısını oluşturuyor.
    return Scaffold(
      // AppBar: Sayfanın üst kısmında bir başlık çubuğu oluşturuyor.
      appBar: AppBar(
        title: const Text(appName), // AppBar başlığını global bir değişken olan "appName" ile ayarlıyor.
      ),

      // Body: Sayfanın ana içeriği.
      body: ListView(
        padding: EdgeInsets.symmetric(
            horizontal: mq.width * .05, // Sağ ve sol kenarlardan ekran genişliğinin %5'ü kadar boşluk bırakıyor.
            vertical: mq.height * .025 // Üst ve alt kenarlardan ekran yüksekliğinin %2.5'i kadar boşluk bırakıyor.
        ),
        // HomeType enum'undaki tüm değerler üzerinden geçiyor ve her biri için bir HomeCard widget'ı oluşturuyor.
        children: HomeType.values.map((e) => HomeCard(homeType: e)).toList(),
      ),
    );
  }
}
