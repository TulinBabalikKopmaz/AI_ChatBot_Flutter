import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/chat_controller.dart';
import '../../helper/global.dart';
import '../../widget/message_card.dart';

// Sohbet botu özelliğini temsil eden ana StatefulWidget sınıfı.
class ChatBotFeature extends StatefulWidget {
  const ChatBotFeature({super.key});

  @override
  State<ChatBotFeature> createState() => _ChatBotFeatureState();
}

class _ChatBotFeatureState extends State<ChatBotFeature> {
  // ChatController sınıfının bir örneği.
  // Mesaj girişini ve sohbet listesini yönetir.
  final _c = ChatController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Uygulamanın üst kısmında gösterilen başlık çubuğu.
      appBar: AppBar(
        // Başlık yazısı.
        title: const Text('Chat with AI Assistant'),
      ),

      // Mesaj giriş alanı ve gönder düğmesi.
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8), // Yatay boşluk.
        child: Row(
          children: [
            // Mesaj giriş alanı.
            Expanded(
              child: TextFormField(
                controller: _c.textC, // Kullanıcıdan alınan metni kontrol eder.
                textAlign: TextAlign.center, // Metin merkezlenir.
                // Kullanıcı giriş alanının dışına dokunduğunda klavye gizlenir.
                onTapOutside: (e) => FocusScope.of(context).unfocus(),
                decoration: InputDecoration(
                  fillColor: Theme.of(context).scaffoldBackgroundColor, // Arka plan rengi.
                  filled: true, // Arka plan renginin uygulanmasını sağlar.
                  isDense: true, // Daha kompakt bir tasarım sağlar.
                  hintText: 'Ask me anything you want...', // İpucu metni.
                  hintStyle: const TextStyle(fontSize: 14), // İpucu metninin stili.
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(50)), // Yuvarlatılmış kenarlar.
                  ),
                ),
              ),
            ),

            // Mesaj alanı ile düğme arasında boşluk.
            const SizedBox(width: 8),

            // Mesaj gönder düğmesi.
            CircleAvatar(
              radius: 24, // Düğmenin boyutu.
              backgroundColor: Colors.blue, // Arka plan rengi.
              child: IconButton(
                onPressed: _c.askQuestion, // Kullanıcı mesajını gönderir.
                icon: const Icon(
                  Icons.rocket_launch_rounded, // Roket simgesi.
                  color: Colors.white, // Simge rengi.
                  size: 28, // Simgenin boyutu.
                ),
              ),
            )
          ],
        ),
      ),

      // Ana içerik: Sohbet mesajlarını gösteren liste.
      body: Obx(
        () => ListView(
          physics: const BouncingScrollPhysics(), // Kaydırma sırasında esnek hareket efekti.
          controller: _c.scrollC, // Listeyi otomatik kaydırmak için kullanılan kontrolcü.
          padding: EdgeInsets.only(
            top: mq.height * .02, // Üst boşluk (dinamik).
            bottom: mq.height * .1, // Alt boşluk (dinamik).
          ),
          // Her bir mesaj, MessageCard widget'ı ile temsil edilir.
          children: _c.list.map((e) => MessageCard(message: e)).toList(),
        ),
      ),
    );
  }
}

// Kullanıcı metin giriş alanına bir mesaj yazar.
// "Gönder" düğmesine basıldığında, ChatController'ın askQuestion metodu çalışır:
// Kullanıcının mesajını işler.
// Mesajı listeye ekler.
// Obx widget'ı, mesaj listesinde bir değişiklik olduğunu algılar ve ekranı otomatik olarak günceller.
// Liste, yeni mesajla birlikte güncellenir ve en son mesaja kaydırılır.