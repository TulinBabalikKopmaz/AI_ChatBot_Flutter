import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

// loading animasyonu için bir widget oluşturduk.
// width ile animasyonun büyüklüğünü ayarlıyoruz.
class CustomLoading extends StatelessWidget {
  const CustomLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Lottie.asset('assets/lottie/loading.json', width: 200);
  }
}

// waitingloading animasyonu için bir widget oluşturduk. 
// width ile animasyonun büyüklüğünü ayarlıyoruz.
// Chat 'in cevap verene kadar olan animasyon
// Translate 'in çeviri yapana kadar olan animasyon
class WaitingLoading extends StatelessWidget {
  const WaitingLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Lottie.asset('assets/lottie/waitingloading.json', width: 200);
  }
}
