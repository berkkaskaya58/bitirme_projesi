import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';

class AlphabetController extends GetxController {
  final vowels = ['A', 'E', 'I', 'İ', 'O', 'Ö', 'U', 'Ü'];
  final consonants = [
    'B', 'C', 'Ç', 'D', 'F', 'G', 'Ğ', 'H', 'J', 'K',
    'L', 'M', 'N', 'P', 'R', 'S', 'Ş', 'T', 'V', 'Y', 'Z'
  ];

  final AudioPlayer _audioPlayer = AudioPlayer();

  /* Future<void> playLetterSound(String letter) async {
    try {
      final path = 'assets/voices/';
      await _audioPlayer.stop(); // Olası önceki sesi durdur
      await _audioPlayer.play(AssetSource(path));
    } catch (e) {
      // Hata yönetimi (örn. dosya yoksa)
      print('Ses dosyası çalınamadı: $e');
    }
  } */

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}