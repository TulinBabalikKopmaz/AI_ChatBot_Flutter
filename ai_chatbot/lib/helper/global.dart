import 'package:flutter/material.dart';

// Bir widget veya değişkenin değişmeyeceğini garanti ediyorsanız, const kullanabilirsiniz.
const appName = 'Ai Assistant';

// Ekran boyutu için tanımlanan değişken
late Size mq;
// Ekran boyutları gibi bazı değerler, widget yapısı tamamen yüklendikten sonra elde edilir. 
// Bu nedenle bu tür değişkenler late olarak tanımlanır.
// late, değişkenin kullanılmadan önce mutlaka bir değer almasını garanti eder. 
// Eğer bir değer verilmeden kullanılmaya çalışılırsa bir hata oluşur.
// Size mq ise kullanılan ekran boyutlarını ifade eden bir değişkendir 

// Google Gemini API Key kullanmak için global değişken atayalım. Aşağıdaki adresten alabiliriz.
// https://aistudio.google.com/app/apikey
String apiKey = 'AIzaSyDUZY8ySJZBvK5if_9eCbM1RxEVRxZQPHA';
String projeNo = '534307107799';

// Uygulamada kullanılacak global değişkenleri burada tanımladık.
