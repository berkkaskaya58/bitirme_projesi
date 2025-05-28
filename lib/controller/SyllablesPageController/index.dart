import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SyllablesPageController extends GetxController {
  RxList<Map<String, dynamic>> words = RxList<Map<String, dynamic>>();

  @override
  void onInit() {
    super.onInit();
    fetchWords();
  }

  void fetchWords() async {
    var snapshot = await FirebaseFirestore.instance.collection('words').get();
    words.value = snapshot.docs.map((doc) {
      String originalText = doc['text'];
      String syllables = splitTextIntoSyllables(originalText);
      return {
        'originalText': originalText,
        'syllables': syllables,
      };
    }).toList();
  }
String splitTextIntoSyllables(String word) {
  final vowels = ['a', 'e', 'ı', 'i', 'o', 'ö', 'u', 'ü'];
  List<String> syllables = [];
  int i = 0;

  // Eğer sadece bir ünlü varsa bölme yapılmaz
  if (word.split('').where((char) => vowels.contains(char)).length <= 1) {
    return word;
  }

  while (i < word.length) {
    int start = i;

    // Sessiz harflerle başlıyorsa onları al (örnek: 'staj')
    while (i < word.length && !vowels.contains(word[i])) {
      i++;
    }

    // İlk ünlü harfi de dahil et
    if (i < word.length && vowels.contains(word[i])) {
      i++;
    }

    // Şimdi ünlüden sonra gelen sessiz harfleri kontrol et
    int consonantStart = i;
    int consonantCount = 0;
    while (i < word.length && !vowels.contains(word[i])) {
      consonantCount++;
      i++;
    }

    // Şimdi kurallara göre geri ayarla
    if (consonantCount == 1 && i < word.length) {
      // Tek sessiz varsa, o sonraki ünlüyle hece kurmalı
      i--;
    } else if (consonantCount == 2 && i < word.length) {
      // İlk sessiz bu heceye, ikinci sonrakiye
      i--;
    } else if (consonantCount >= 3 && i < word.length) {
      // İlk iki sessiz bu heceye, üçüncü sonrakiye
      i -= (consonantCount - 1);
    }

    syllables.add(word.substring(start, i));
  }

  return syllables.join("-");
}







}
