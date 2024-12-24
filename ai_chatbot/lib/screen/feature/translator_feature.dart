import 'package:ai_assistant/widget/custom_loading.dart'; // Özel bir yüklenme animasyonu widget'ını içe aktarır.
import 'package:flutter/cupertino.dart'; // Cupertino (iOS tarzı) bileşenleri sağlar.
import 'package:flutter/material.dart'; // Material Design bileşenleri sağlar.
import 'package:get/get.dart'; // GetX kütüphanesi için içe aktarma. Durum yönetimi ve rota işlemleri için kullanılır.

import '../../controller/translate_controller.dart'; // TranslateController sınıfı içe aktarılır.
import '../../helper/global.dart'; // Uygulama genelinde kullanılan yardımcı sınıf veya değişkenler.
import '../../widget/custom_btn.dart'; // Özel bir buton widget'ı.
import '../../widget/language_sheet.dart'; // Dil seçimi için kullanılan alt pencere widget'ı.

// Translator özelliği için StatefulWidget tanımı.
class TranslatorFeature extends StatefulWidget {
  const TranslatorFeature({super.key});

  @override
  State<TranslatorFeature> createState() => _TranslatorFeatureState();
}

// StatefulWidget için durum sınıfı.
class _TranslatorFeatureState extends State<TranslatorFeature> {
  // TranslateController örneği oluşturuluyor. Bu, tercüme işlemlerini yönetir.
  final _c = TranslateController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Uygulama çubuğu (AppBar)
      appBar: AppBar(
        title: const Text('Multi Language Translator'), // Başlık
      ),

      // Ana içerik gövdesi (Body)
      body: ListView(
        physics: const BouncingScrollPhysics(), // Listeye yumuşak bir kaydırma fiziği ekler.
        padding: EdgeInsets.only(
            top: mq.height * .02, bottom: mq.height * .1), // Dinamik üst ve alt dolgu.

        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Kaynak dil (from language) seçimi
              InkWell(
                onTap: () => Get.bottomSheet(
                    LanguageSheet(c: _c, s: _c.from)), // Dil seçimi alt penceresi açılır.
                borderRadius: const BorderRadius.all(Radius.circular(15)),
                child: Container(
                  height: 50,
                  width: mq.width * .4, // Cihaz genişliğine göre oranlama.
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.blue),
                      borderRadius:
                      const BorderRadius.all(Radius.circular(15))),
                  child: Obx(() =>
                      Text(_c.from.isEmpty ? 'Auto' : _c.from.value)), // Seçili dil gösterilir.
                ),
              ),

              // Dil değiştirme (swap) düğmesi
              IconButton(
                onPressed: _c.swapLanguages, // Dillerin yerini değiştirir.
                icon: Obx(
                      () => Icon(
                    CupertinoIcons.repeat,
                    color: _c.to.isNotEmpty && _c.from.isNotEmpty
                        ? Colors.blue // Diller seçiliyse mavi.
                        : Colors.grey, // Aksi takdirde gri.
                  ),
                ),
              ),

              // Hedef dil (to language) seçimi
              InkWell(
                onTap: () => Get.bottomSheet(
                    LanguageSheet(c: _c, s: _c.to)), // Dil seçimi alt penceresi açılır.
                borderRadius: const BorderRadius.all(Radius.circular(15)),
                child: Container(
                  height: 50,
                  width: mq.width * .4,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.blue),
                      borderRadius:
                      const BorderRadius.all(Radius.circular(15))),
                  child: Obx(() =>
                      Text(_c.to.isEmpty ? 'To' : _c.to.value)), // Seçili dil gösterilir.
                ),
              ),
            ],
          ),

          // Çeviri için metin girişi (text field)
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: mq.width * .04, vertical: mq.height * .035),
            child: TextFormField(
              controller: _c.textC, // Metin kontrolcüsü.
              minLines: 5,
              maxLines: null, // Çok satırlı giriş.
              onTapOutside: (e) =>
                  FocusScope.of(context).unfocus(), // Odak dışına tıklayınca klavye kapanır.
              decoration: const InputDecoration(
                  hintText: 'Translate anything you want...', // İpucu metni.
                  hintStyle: TextStyle(fontSize: 13.5),
                  border: OutlineInputBorder(
                      borderRadius:
                      BorderRadius.all(Radius.circular(10)))),
            ),
          ),

          // Çeviri sonucu (result field)
          Obx(() => _translateResult()),

          // Alt boşluk için mesafe
          SizedBox(height: mq.height * .04),

          // Çevir butonu
          CustomBtn(
            onTap: _c.googleTranslate, // Google Translate API çağrısı.
            text: 'Translate', // Buton metni.
          ),
        ],
      ),
    );
  }

  // Çeviri sonucu widget'ı
  Widget _translateResult() => switch (_c.status.value) {
  // Hiçbir şey yoksa boş bir widget döndürür.
    Status.none => const SizedBox(),

  // Çeviri tamamlandığında sonucu bir metin alanında gösterir.
    Status.complete => Padding(
      padding: EdgeInsets.symmetric(horizontal: mq.width * .04),
      child: TextFormField(
        controller: _c.resultC, // Çeviri sonucu kontrolcüsü.
        maxLines: null,
        onTapOutside: (e) =>
            FocusScope.of(context).unfocus(), // Odak dışına tıklayınca klavye kapanır.
        decoration: const InputDecoration(
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)))),
      ),
    ),

  // Çeviri yükleniyorsa özel bir yükleme animasyonu gösterir.
    Status.loading => const Align(child: WaitingLoading())
  };
}
