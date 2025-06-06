import 'package:bitirme_projesi/View/words_home_page_new/index.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:math';

class TestPageController extends GetxController {
  RxList<Map<String, dynamic>> questions = RxList<Map<String, dynamic>>();
  RxInt currentIndex = 0.obs;
  RxString feedbackMessage = "".obs;
  RxInt correctAnswers = 0.obs;
  RxInt wrongAnswers = 0.obs;
  RxBool testCompleted = false.obs;
  RxBool isAnswered = false.obs; // **Şık seçildiğinde kilitleme mekanizması**
  RxList<String> currentChoices = RxList<String>(); // Şıkları tutacak liste

  @override
  void onInit() {
    super.onInit();
    fetchQuestions();
  }

  void fetchQuestions() async {
    var snapshot = await FirebaseFirestore.instance.collection('words').get();
    questions.value = snapshot.docs.map((doc) {
      String imageData = doc.data()["imageBase64"] ?? "";
      return {'text': doc.id, 'imageBase64': imageData};
    }).toList();
    generateChoices(); // İlk şıkları oluştur
  }

  // Şıkları karıştırma fonksiyonu
  void generateChoices() {
    List<String> allWords = questions.map((q) => q['text'] as String).toList();
    String correctAnswer = questions[currentIndex.value]['text'];
    
    // Doğru cevabı listeden çıkar
    allWords.remove(correctAnswer);
    
    // Rastgele 2 yanlış cevap seç
    allWords.shuffle();
    List<String> wrongChoices = allWords.take(2).toList();
    
    // Doğru cevabı ekle ve karıştır
    List<String> choices = [...wrongChoices, correctAnswer];
    choices.shuffle();
    
    currentChoices.value = choices;
  }

  void checkAnswer(String selected) {
    if (isAnswered.value) return;

    isAnswered.value = true;

    if (selected == questions[currentIndex.value]['text']) {
      feedbackMessage.value = "✅ Tebrikler!";
      correctAnswers.value++;

      if (currentIndex.value == questions.length - 1) {
        testCompleted.value = true;
        feedbackMessage.value = "🏆 Test tamamlandı!";
        Future.delayed(const Duration(seconds: 3), () {
          Get.offAll(() => const WordsHomePage());
        });
        return;
      } else {
        Future.delayed(const Duration(microseconds: 500), () { 
          currentIndex.value++;
          feedbackMessage.value = "";
          isAnswered.value = false;
          generateChoices(); // Yeni şıkları oluştur
        });
      }
    } else {
      feedbackMessage.value = "❌ Tekrar dene!";
      wrongAnswers.value++;

      Future.delayed(const Duration(seconds: 1), () {
        feedbackMessage.value = "";
        isAnswered.value = false;
      });
    }
  }
}