import 'package:bitirme_projesi/View/words_home_page/index.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert';

class TestPageController extends GetxController {
  RxList<Map<String, dynamic>> questions = RxList<Map<String, dynamic>>();
  RxInt currentIndex = 0.obs;
  RxString feedbackMessage = "".obs;
  RxInt correctAnswers = 0.obs;
  RxInt wrongAnswers = 0.obs;
  RxBool testCompleted = false.obs;
  RxBool isAnswered = false.obs; // **Şık seçildiğinde kilitleme mekanizması**

  @override
  void onInit() {
    super.onInit();
    fetchQuestions();
  }

  void fetchQuestions() async {
    var snapshot = await FirebaseFirestore.instance.collection('words').get();
    questions.value = snapshot.docs.map((doc) {
      String imageData = doc.data()?["imageBase64"] ?? "";
      return {'text': doc.id, 'imageBase64': imageData};
    }).toList();
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
        Future.delayed(Duration(seconds: 3), () {
          Get.offAll(() => WordsHomePage());
        });
        return;
      } else {
        Future.delayed(Duration(microseconds: 500), () { 
          currentIndex.value++;
          feedbackMessage.value = "";
          isAnswered.value = false;
        });
      }
    } else {
      feedbackMessage.value = "❌ Tekrar dene!";
      wrongAnswers.value++;

      Future.delayed(Duration(seconds: 1), () {
        feedbackMessage.value = "";
        isAnswered.value = false;
      });
    }
}


}