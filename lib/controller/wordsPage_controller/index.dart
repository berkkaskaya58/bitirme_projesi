import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class WordsPageController extends GetxController {
  final PageController pageController = PageController();
  RxList<QueryDocumentSnapshot> words = RxList<QueryDocumentSnapshot>();
  final FlutterTts flutterTts = FlutterTts();

  Future<void> speakText(String text) async {
    await flutterTts.setLanguage("tr-TR");
    await flutterTts.setSpeechRate(0.5);
    await flutterTts.setPitch(1.0);
    await flutterTts.speak(text);
  }

  @override
  void onInit() {
    super.onInit();
    fetchWords();
  }

  void fetchWords() async {
    var snapshot = await FirebaseFirestore.instance.collection('words').get();
    words.value = snapshot.docs;
  }

  void nextPage() {
    if (pageController.page! < words.length - 1) {
      pageController.nextPage(duration: Duration(milliseconds: 300), curve: Curves.easeIn);
    }
  }

  void prevPage() {
    if (pageController.page! > 0) {
      pageController.previousPage(duration: Duration(milliseconds: 300), curve: Curves.easeIn);
    }
  }
}
