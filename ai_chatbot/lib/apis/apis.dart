import 'dart:developer';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:translator_plus/translator_plus.dart';

import '../helper/global.dart';

class APIs {

  // Google Gemini API ' den cevap alabilmek için bir fonksiyon yazdık. 
  // Fonksiyon tek bir parametre alır. "question"
  // String question: Kullanıcının sorduğu soru.
  static Future<String> getAnswer(String question)

  async { // fonksiyonun asenkron çalışmasını sağlar.

    try { // Hata yoksa

      log('api key: $apiKey'); // API anahtarını log'lamak için kullanılır. Bu, genellikle API isteğini yapmadan önce bir hata olup olmadığını kontrol eder.
      
      final model = GenerativeModel( //GenerativeModel: Google Gemini API kullanarak generatif (üreten) cevaplar almak için bir model oluşturur.
        model: 'gemini-1.5-flash-latest', // model: 'gemini-1.5-flash-latest': Kullandığımız modelin versiyonu belirtilir. 
        apiKey: apiKey, // apiKey: API'yi kullanabilmek için gerekli olan anahtar. global.dart tanımladık.
        // final bir değişkene yalnızca bir kez değer atanabilir. Atandıktan sonra bu değer değiştirilemez.
        // model'e bir kez değer atandıktan sonra değeri değiştirilemez. Ancak model'in içindeki özelliklere erişim yapılabilir.
        // Neden final kullanımdı? model nesnesinin başka bir nesneyle değiştirilemeyeceğini garantilemek için.
      );

      final content = [Content.text(question)];
      // Google Gemini API, Content nesneleri ile çalışır.
      // Burada kullanıcının sorusu Content.text olarak hazırlanır.

      final response = await model.generateContent(content, safetySettings: [
        SafetySetting(HarmCategory.dangerousContent, HarmBlockThreshold.none), // Şiddet, kendine zarar verme, yasa dışı aktiviteler
        SafetySetting(HarmCategory.sexuallyExplicit, HarmBlockThreshold.none), // Cinsel olarak açık içerikler
        SafetySetting(HarmCategory.harassment, HarmBlockThreshold.none), // Taciz veya zorbalıkla ilgili içerikler
        SafetySetting(HarmCategory.hateSpeech, HarmBlockThreshold.none), // Nefret söylemi içerikler

        // generateContent: İçeriği Google Gemini API'ye gönderir ve bir cevap bekler.
        // safetySettings: zararlı içerik filtreleri kapatılmıştır (HarmBlockThreshold.none). 
        // İstenirse filtre aktif edilerek bu konularda soru sorduğunda uygun cevap oluşturması engelenebilir.
       
      ]);

      log('res: ${response.text}'); // API'den gelen cevap log'lanır.
      return response.text!; // fonksiyon sonuç olarak bu loglanmış cevabı döndürür.
    } 
    
    catch (e) { // Eğer bir hata oluşursa bu kısım devreye girer
      log('getAnswerGeminiE: $e'); // Hata loglanır.
      return 'Something went wrong (Try again in sometime)'; // Geriye burada yazan mesajı bize gösterir. Hata mesajını görmeyiz burada yazanı görürüz.
    }
  }


  // Google Gemini Translate ' den cevap alabilmek için bir fonksiyon yazdık.
  // Fonksiyon 3 parametre alır.
  // required String from: Çevrilecek metnin dili (kaynak dil, örneğin "en").
  // required String to: Çevrilecek dil (hedef dil, örneğin "tr").
  // required String text: Çevrilecek metin.
  static Future<String> googleTranslate({required String from, required String to, required String text}) 
  async { // fonksiyonun asenkron çalışmasını sağlar.

    try { // Hata yoksa

      final res = await GoogleTranslator().translate(text, from: from, to: to); // GoogleTranslator: Google Translate servisini kullanarak metin çevirisi yapar. translate: Çeviri işlemini başlatır ve bir sonuç döner.
      return res.text; // fonksiyon sonuç olarak bu çeviri döndürür. 
    } 
    
    catch (e) { // Eğer bir hata oluşursa bu kısım devreye girer

      log('googleTranslateE: $e '); // Hata loglanır.

      return 'Something went wrong!'; // // Geriye burada yazan mesajı bize gösterir. Hata mesajını görmeyiz burada yazanı görürüz.
    }
  }
}

// APIs sınıfı, iki ana asenkron fonksiyon içeriyor:
// getAnswer: Google Gemini API kullanarak verilen bir soruya cevap alır.
// googleTranslate: Google Translate API kullanarak bir metni başka bir dile çevirir.

// Logging (loglama), bir programın çalışması sırasında meydana gelen olayları, durumları veya hataları kayıt altına almayı ifade eder.
// Asenkron Çalışma: Bir işi yaparken beklemek zorunda kalmazsın; bir işi başlatır ve devam ederken başka bir işe geçersin. Böylece Apıden gelen cevabı beklemeden başka soru sorabilir veya çeviri yaptrırabilirsin.
