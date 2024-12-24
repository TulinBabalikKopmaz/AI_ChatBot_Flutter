import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../apis/apis.dart';

// Çeviri işlemlerinin durumunu belirten bir enum tanımı.
enum Status { none, loading, complete }

// TranslateController sınıfı, Flutter uygulamasında dil çevirisi işlemleri için kullanılan bir kontrolcü.
class TranslateController extends GetxController {
  // Kullanıcının çevirmek istediği metni yazdığı metin kontrolcüsü.
  final textC = TextEditingController();

  // Çeviri sonucunun görüntüleneceği metin kontrolcüsü.
  final resultC = TextEditingController();

  // Kaynak dil ve hedef dil için RxString (reaktif değişken) tanımları.
  final from = ''.obs, to = ''.obs;

  // Çeviri işleminin durumunu tutan Rx değişken.
  final status = Status.none.obs;


  // Kaynak dil ve hedef dil değerlerini yer değiştirir.
  void swapLanguages() {
    if (to.isNotEmpty && from.isNotEmpty) {
      // Hedef ve kaynak dil arasında değişim yapılır.
      final t = to.value;
      to.value = from.value;
      from.value = t;
    }
  }

  // Google Translate kullanarak çeviri yapan fonksiyon.
  Future<void> googleTranslate() async {
    // Kullanıcı metin girmiş ve hedef dil seçilmişse işlem başlatılır.
    if (textC.text.trim().isNotEmpty && to.isNotEmpty) {
      // Durum "loading" olarak ayarlanır.
      status.value = Status.loading;

      // Google Translate API'sinden çeviri sonucunu alır ve sonuç kontrolcüsüne yazar.
      resultC.text = await APIs.googleTranslate(
          from: jsonLang[from.value] ?? 'auto',   // Kaynak dil (belirtilmezse 'auto')
          to: jsonLang[to.value] ?? 'en',         // Hedef dil (varsayılan İngilizce)
          text: textC.text);

      // İşlem tamamlandığında durum "complete" olarak güncellenir.
      status.value = Status.complete;
    }
  }

  // Kullanılabilir dillerin listesini döndüren bir değişken.
  late final lang = jsonLang.keys.toList();

  // Desteklenen dillerin kodları ve isimleri.
  final jsonLang = const {
    // 'Automatic': 'auto',
    'English': 'en',
    'French': 'fr',
    'German': 'de',
    'Turkish': 'tr'
  };
}
