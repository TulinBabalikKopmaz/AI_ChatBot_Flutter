class Message {
  String msg;
  final MessageType msgType;

  Message({required this.msg, required this.msgType}); // yapıcı metod
}

// Message sınıfı, bir mesajı temsil etsin ve iki özelliği var.
// String msg: Bu, mesajın içeriğini tutar. Mesaj metni, bir String veri tipiyle saklanır.
// final MessageType msgType: Bu, mesajın türünü belirtir. Örneğin, mesajın bir kullanıcıdan mı yoksa bir bot'tan mı geldiğini belirler. 
// MessageType adında bir enum ile tanımlanır ve final anahtar kelimesiyle bu değer bir kez atandıktan sonra değiştirilemez.

// Constructor: Yapıcı metod içinde, msg ve msgType değerleri required olarak belirtilmiş, yani bu sınıfı oluştururken her ikisinin de sağlanması zorunludur.
// required this.msg: Mesajın içeriği (metin) gerektiği için bu parametreyi zorunlu kılar.
// required this.msgType: Mesajın türünü (kullanıcı veya bot) belirtmek için bu parametre de zorunludur.

enum MessageType { user, bot }
// Bir enum'dır (sınırlı değer kümesi). 
// Bu enum, mesajın türünü belirtmek için kullanılır ve iki değeri vardır:
// user: Mesajın bir kullanıcıdan geldiğini belirtir.
// bot: Mesajın bir bot'tan geldiğini belirtir.

// Mesaj için genel bir yapı oluşturduk