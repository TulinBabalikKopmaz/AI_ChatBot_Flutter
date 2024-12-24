// Dart dilindeki `developer` kütüphanesi, loglama işlemleri için kullanılır.
import 'dart:developer';

// Flutter'da Material tasarımı bileşenlerini içe aktarır.
import 'package:flutter/material.dart';

// GetX kütüphanesini içe aktarır, durum yönetimi için kullanılır.
import 'package:get/get.dart';

// Çeviri işlemleri için kullanılan kontrolör sınıfını içe aktarır.
import '../controller/translate_controller.dart';

// Uygulama genelindeki yardımcı değişkenler ve fonksiyonlar için bir modül.
import '../helper/global.dart';

// `LanguageSheet` widget'ı, dil seçim ekranını gösterir.
class LanguageSheet extends StatefulWidget {
  // Çeviri kontrolörü (TranslateController) referansı.
  final TranslateController c;

  // Seçili dili temsil eden reaktif bir string.
  final RxString s;

  // Constructor: Çeviri kontrolörünü ve seçili dili alır.
  const LanguageSheet({super.key, required this.c, required this.s});

  @override
  State<LanguageSheet> createState() => _LanguageSheetState();
}

// `_LanguageSheetState` sınıfı, widget'ın durumunu yönetir.
class _LanguageSheetState extends State<LanguageSheet> {
  // Arama kutusundaki metni saklayan reaktif bir değişken.
  final _search = ''.obs;

  @override
  Widget build(BuildContext context) {
    return Container(
      // Alt sayfanın yüksekliğini ekranın yarısına ayarlar.
      height: mq.height * .5,

      // Kenar boşlukları ekler.
      padding: EdgeInsets.only(
          left: mq.width * .04, right: mq.width * .04, top: mq.height * .02),

      // Arka plan rengini ve üst kenarlardaki yuvarlatma efektini tanımlar.
      decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(15), topRight: Radius.circular(15))),

      // Widget hiyerarşisi.
      child: Column(
        children: [
          // Arama kutusu, dilleri filtrelemek için kullanılır.
          TextFormField(
            // Kullanıcı yazdıkça `_search` değişkeni güncellenir.
            onChanged: (s) => _search.value = s.toLowerCase(),

            // Kullanıcı dış bir alana tıkladığında klavye kapanır.
            onTapOutside: (e) => FocusScope.of(context).unfocus(),

            // Arama kutusu için tasarım özellikleri.
            decoration: const InputDecoration(
                prefixIcon: Icon(Icons.translate_rounded, color: Colors.blue),
                hintText: 'Search Language...', // Yer tutucu metin.
                hintStyle: TextStyle(fontSize: 14),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)))),
          ),

          // Listeyi genişletilebilir hale getirir.
          Expanded(
            child: Obx(
                  () {
                // Arama metni boşsa tüm dilleri gösterir, değilse filtre uygular.
                final List<String> list = _search.isEmpty
                    ? widget.c.lang
                    : widget.c.lang
                    .where((e) => e.toLowerCase().contains(_search.value))
                    .toList();

                // ListView kullanarak dilleri ekrana yazdırır.
                return ListView.builder(
                  // Kaydırma fiziksel davranışlarını tanımlar.
                  physics: const BouncingScrollPhysics(),

                  // Listede gösterilecek öğe sayısını belirtir.
                  itemCount: list.length,

                  // Listede elemanlar arasında boşluk bırakır.
                  padding: EdgeInsets.only(top: mq.height * .02, left: 6),

                  // Liste öğelerini oluşturur.
                  itemBuilder: (ctx, i) {
                    return InkWell(
                      // Bir dil seçildiğinde, seçili dil (`widget.s`) güncellenir.
                      onTap: () {
                        widget.s.value = list[i]; // Seçili dili günceller.
                        log(list[i]); // Seçilen dili loglar.
                        Get.back(); // Alt sayfayı kapatır.
                      },
                      child: Padding(
                        // Liste öğeleri arasına boşluk ekler.
                        padding: EdgeInsets.only(bottom: mq.height * .02),
                        // Dil adını ekrana yazdırır.
                        child: Text(list[i]),
                      ),
                    );
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
