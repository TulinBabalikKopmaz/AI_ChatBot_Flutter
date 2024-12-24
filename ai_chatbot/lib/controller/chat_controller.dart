import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../apis/apis.dart';
import '../model/message.dart';

class ChatController extends GetxController { // Sohbet uygulamasındaki kullanıcı mesajlarını ve bot yanıtlarını yönetmek için.
  
  final textC = TextEditingController(); // Kullanıcının yazdığı mesajı kontrol etmek ve metni almak için

  final scrollC = ScrollController(); // Yeni mesaj eklendiğinde sohbet ekranını otomatik olarak en alta kaydırmak için 

  final list = <Message>[ // Mesajları tutan bir liste. Bu liste, hem kullanıcı mesajlarını hem de bot mesajlarını tutucak
    
    Message(msg: 'Hello, How can I help you?', msgType: MessageType.bot) // Liste, başlangıçta mesajı "Hello, How can I help you?"
  
  ].obs; //GetX'in reaktif bir özelliğidir. Liste değiştiğinde (yeni mesaj eklendiğinde veya silindiğinde), GetX otomatik olarak UI'yi günceller.

  Future<void> askQuestion() async { // Bu fonksiyon, kullanıcı bir soru sorduğunda çalıştırılır ve bot yanıtını ekler. (Asenkron)

    if (textC.text.trim().isNotEmpty) { // Kullanıcının yazdığı metin boş olup olmadığını kontrol eder.

      // Kullanıcı
      list.add(Message(msg: textC.text, msgType: MessageType.user)); // Kullanıcının yazdığı mesaj list'e eklenir.
      list.add(Message(msg: '', msgType: MessageType.bot)); // Bot yanıtı için geçici olarak boş bir mesaj eklenir. Yanıt gelirken bot'un "düşünüyor" gibi görünmesini sağlar.
      _scrollDown(); // Yeni mesaj eklendikten sonra sohbet ekranını otomatik olarak en alta kaydırır.

      final res = await APIs.getAnswer(textC.text);
      // Kullanıcının yazdığı metin, bir API çağrısıyla APIs.getAnswer() fonksiyonuna gönderilir.
      // Bu işlem asenkron çalışır, yani yanıt gelene kadar uygulama donmaz.

      // Bot
      list.removeLast(); // Botun boş mesajı kaldırılır.
      list.add(Message(msg: res, msgType: MessageType.bot)); // API'den dönen yanıt alınarak yeni bir bot mesajı olarak listeye eklenir.
      _scrollDown();

      textC.text = ''; // Kullanıcının yazdığı metin temizlenir.
    } 
  }

  
  void _scrollDown() { // Yeni bir mesaj eklendiğinde, sohbet ekranını en sona kaydırır
    
    scrollC.animateTo(scrollC.position.maxScrollExtent, // Ekranın en alt konumunu temsil eder.
        
        duration: const Duration(milliseconds: 500), curve: Curves.ease);} // Ekranı belirtilen konuma kaydırır. Kaydırma işlemi 500 milisaniye sürer ve yumuşak bir eğri kullanır.
}
