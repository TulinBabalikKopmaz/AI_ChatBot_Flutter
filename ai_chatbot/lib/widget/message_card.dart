import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

import '../helper/global.dart';
import '../model/message.dart';

// Mesaj kartını temsil eden StatelessWidget sınıfı.
class MessageCard extends StatelessWidget {
  // Gösterilecek mesaj verisi.
  final Message message;

  // Sınıfın yapılandırıcısı, gerekli mesaj verisini alır.
  const MessageCard({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    // Kartın kenarları için yarıçap değeri.
    const r = Radius.circular(15);

    return message.msgType == MessageType.bot
        // Eğer mesaj bir bot tarafından gönderilmişse, aşağıdaki widget oluşturulur.
        ? Row(
            children: [
              // Sol boşluk.
              const SizedBox(width: 6),

              // Bot için logo görüntüsü.
              CircleAvatar(
                radius: 18,
                backgroundColor: Colors.white,
                child: Image.asset('assets/images/logo.png', width: 24),
              ),

              // Mesaj içeriğini gösteren kutu.
              Container(
                constraints: BoxConstraints(maxWidth: mq.width * .6), // Maksimum genişlik.
                margin: EdgeInsets.only(
                    bottom: mq.height * .02, left: mq.width * .02), // Kenar boşlukları.
                padding: EdgeInsets.symmetric(
                    vertical: mq.height * .01, horizontal: mq.width * .02), // İçerik boşlukları.
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black54), // Kenarlık rengi.
                    borderRadius: const BorderRadius.only(
                        topLeft: r, topRight: r, bottomRight: r)), // Yuvarlatılmış kenarlar.
                // Mesaj içeriği boşsa animasyonlu metin gösterilir.
                child: message.msg.isEmpty
                    ? AnimatedTextKit(animatedTexts: [
                        TypewriterAnimatedText(
                          ' Please wait... ', // Yükleniyor mesajı.
                          speed: const Duration(milliseconds: 100), // Yazma hızı.
                        ),
                      ], repeatForever: true) // Animasyonun sürekli tekrarlanması.
                    : Text(
                        message.msg, // Mesaj içeriği.
                        textAlign: TextAlign.center, // Metin ortalanır.
                      ),
              )
            ])
        // Eğer mesaj bir kullanıcı tarafından gönderilmişse, aşağıdaki widget oluşturulur.
        : Row(
            mainAxisAlignment: MainAxisAlignment.end, // Kullanıcı mesajı sağda hizalanır.
            children: [
              // Kullanıcı mesajını gösteren kutu.
              Container(
                  constraints: BoxConstraints(maxWidth: mq.width * .6), // Maksimum genişlik.
                  margin: EdgeInsets.only(
                      bottom: mq.height * .02, right: mq.width * .02), // Kenar boşlukları.
                  padding: EdgeInsets.symmetric(
                      vertical: mq.height * .01, horizontal: mq.width * .02), // İçerik boşlukları.
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black54), // Kenarlık rengi.
                      borderRadius: const BorderRadius.only(
                          topLeft: r, topRight: r, bottomLeft: r)), // Yuvarlatılmış kenarlar.
                  child: Text(
                    message.msg, // Mesaj içeriği.
                    textAlign: TextAlign.center, // Metin ortalanır.
                  )),

              // Kullanıcı simgesi.
              const CircleAvatar(
                radius: 18,
                backgroundColor: Colors.white,
                child: Icon(Icons.person, color: Colors.blue), // Kullanıcı ikonu.
              ),
              
              const SizedBox(width: 6),// Sağ boşluk.
            ]);
  }
}