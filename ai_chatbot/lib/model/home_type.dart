import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../screen/feature/chatbot_feature.dart';
import '../screen/feature/translator_feature.dart';

// Enum yapısı sayesinde uygulama içinde yaptığımız farklı card kısımlarını diğerleri içinde kullanabiliriz.
enum HomeType { aiChatBot, aiTranslator } 

extension MyHomeType on HomeType {
  // Her bir HomeType için uygun başlık değerleri döndürülüyor.
  // Home scrende yer alan cardların üzerinde yazan başlıklar.
  String get title => switch (this) {
        HomeType.aiChatBot => 'AI ChatBot',
        HomeType.aiTranslator => 'Translator',
      };

  // Her bir HomeType için uygun Lottie animasyon dosyası döndürülüyor.
  // Home scrende yer alan cardların üzerindeki animasyonlar.
  String get lottie => switch (this) {
        HomeType.aiChatBot => 'chatbot.json',
        HomeType.aiTranslator => 'translator.json',
      };

  // Her bir HomeType için içerik hizalama bilgisi döndürülüyor.
  bool get leftAlign => switch (this) {
        HomeType.aiChatBot => true, // AI ChatBot için içerik sola hizalanıyor
        HomeType.aiTranslator => false, // Translator için içerik sağa hizalanıyor.
      };

  // Her bir HomeType için uygun padding değerleri döndürülüyor.
  EdgeInsets get padding => switch (this) {
        HomeType.aiChatBot => EdgeInsets.zero, // AI ChatBot için padding yok.
        HomeType.aiTranslator => const EdgeInsets.all(20), // Translator için tüm kenarlarda 20 piksel boşluk.
      };


  // Her bir HomeType için card tıkladığımızda ona özel sayfaya gidicek.
  VoidCallback get onTap => switch (this) {
        HomeType.aiChatBot => () => Get.to(() => const ChatBotFeature()),
        HomeType.aiTranslator => () => Get.to(() => const TranslatorFeature()),
      };
}
