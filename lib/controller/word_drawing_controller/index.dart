import 'dart:typed_data';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert';

class WordsDrawingController extends GetxController {
  RxString text = ''.obs;
  Rx<Uint8List?> imageBytes = Rx<Uint8List?>(null);
  RxBool isLoading = true.obs; // Yüklenme durumunu kontrol etmek için

  @override
  void onInit() {
    super.onInit();
    fetchWordData("wordID"); // Dinamik ID ile veri çekme işlemi
  }

  void fetchWordData(String wordID) async {
  try {
    print("Veri çekme işlemi başladı... [wordID: $wordID]"); // ID'yi konsolda test ediyoruz
    var snapshot = await FirebaseFirestore.instance.collection('words').doc(wordID).get();
    
    if (snapshot.exists) {
      print("Veri başarıyla çekildi: ${snapshot.data()}");

      String base64Image = snapshot.data()?['imageBase64'] ?? '';
      if (base64Image.isNotEmpty) {
        imageBytes.value = base64Decode(base64Image);
      } else {
        print("HATA: imageBase64 verisi boş!");
      }
      
      text.value = snapshot.data()?['text'] ?? '';
    } else {
      print("Doküman bulunamadı! [ID: $wordID]");
    }
  } catch (e) {
    print("Hata oluştu: $e");
  } finally {
    isLoading.value = false;
  }
}

}
