import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';

class HomePageController extends GetxController {
  final FlutterTts _flutterTts = FlutterTts();

  @override
  void onInit() {
    super.onInit();
    _initTts();
  }

  void _initTts() async {
    await _flutterTts.setLanguage("tr-TR");
    await _flutterTts.setSpeechRate(0.5); 
    await _flutterTts.setPitch(1.2); 
  }

  void speakText(String text) async {
    await _flutterTts.stop(); 
    await _flutterTts.speak(text);
  }
}