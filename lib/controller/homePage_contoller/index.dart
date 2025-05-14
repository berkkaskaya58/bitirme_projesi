import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';

class HomePageController extends GetxController {
  late AudioPlayer player;

  @override
  void onInit() {
    super.onInit();
    player = AudioPlayer();
  }

  Future<void> playVoice(String path) async {
    try {
      await player.stop(); // Daha önceki sesi durdur
      await player.setAsset(path); // Yeni sesi ayarla
      await player.play(); // Sesi çal
    } catch (e) {
      print("Ses çalma hatası: $e");
    }
  }

  @override
  void onClose() {
    player.dispose(); // Hafızayı temizle
    super.onClose();
  }
}