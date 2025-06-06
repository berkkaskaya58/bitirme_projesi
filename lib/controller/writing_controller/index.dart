import 'package:get/get.dart';

class WritingController extends GetxController {
  final words = <Map<String, dynamic>>[].obs;
  final currentIndex = 0.obs;
  final isAnswered = false.obs;
  final isCorrect = false.obs;
  final animatedText = ''.obs;
  final clearDrawing = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadWords();
  }

  void loadWords() {
    // Örnek kelimeler
    words.value = [
      {'text': 'ev', 'image': 'assets/images/ev.png'},
      {'text': 'kalem', 'image': 'assets/images/kalem.png'},
      {'text': 'kitap', 'image': 'assets/images/kitap.png'},
      {'text': 'masa', 'image': 'assets/images/masa.png'},
      {'text': 'sandalye', 'image': 'assets/images/sandalye.png'},
    ];
    updateAnimatedText();
  }

  void updateAnimatedText() {
    if (words.isNotEmpty) {
      animatedText.value = words[currentIndex.value]['text'];
    }
  }

  void nextWord() {
    if (currentIndex.value < words.length - 1) {
      currentIndex.value++;
      isAnswered.value = false;
      isCorrect.value = false;
      clearDrawing.value = true;
      updateAnimatedText();
    }
  }

  void previousWord() {
    if (currentIndex.value > 0) {
      currentIndex.value--;
      isAnswered.value = false;
      isCorrect.value = false;
      clearDrawing.value = true;
      updateAnimatedText();
    }
  }

  void checkAnswer(bool correct) {
    isAnswered.value = true;
    isCorrect.value = correct;
  }

  void drawingCleared() {
    clearDrawing.value = false;
  }
} 