// lib/controller/onboarding_controller.dart
import 'package:bitirme_projesi/ui/ui_voice/index.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingController extends GetxController {
  var isFirstTime = true.obs;
  late AudioPlayer player;

  // ✅ Sayfa geçişlerini kontrol etmek için kullanılan liste
  final List<bool> hasPlayed = [false, false, false];

  @override
  void onInit() {
    checkIfFirstTime();
    super.onInit();
    player = AudioPlayer();
  }

  // ✅ Uygulama ilk defa açılıyorsa true, değilse false
  void checkIfFirstTime() async {
    final prefs = await SharedPreferences.getInstance();
    isFirstTime.value = prefs.getBool("isFirstTime") ?? true;
  }

  // ✅ Onboarding tamamlandığında çağrılır
  void completeOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool("isFirstTime", false);
    isFirstTime.value = false;
  }

  // ✅ Ses çalma fonksiyonu (sayfa değişimi sırasında ses çalacak)
  void playSound(int pageIndex) async {
    if (!hasPlayed[pageIndex]) {
      hasPlayed[pageIndex] = true;

      // Sayfa indexine göre doğru ses dosyasını seç
      String? voicePath;
      if (pageIndex == 0) voicePath = UIVoices.onboarding1;
      if (pageIndex == 1) voicePath = UIVoices.onboarding2;
      if (pageIndex == 2) voicePath = UIVoices.onboarding3;

      if (voicePath != null) {
        await player.setAsset(voicePath);  // Ses dosyasını yükle
        await player.play();               // Ses dosyasını çal
      }
    }
  }

  // ✅ Player'ı baştan başlatma fonksiyonu
  void restartSound() {
    player.seek(Duration.zero); // Baştan başlat
    player.play();
  }

  @override
  void onClose() {
    player.dispose();
    super.onClose();
  }
}