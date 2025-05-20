import 'dart:typed_data';
import 'package:bitirme_projesi/controller/test_controller/index.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:convert';

class TestPage extends StatelessWidget {
  final TestPageController controller = Get.put(TestPageController());

  @override
  Widget build(BuildContext context) {
    double pageWidth = MediaQuery.of(context).size.width;
    double pageHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(title: Text("Test Sayfası")),
      body: Center(
        child: Obx(() => controller.questions.isEmpty
            ? CircularProgressIndicator()
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // **Doğru - Yanlış Sayaçları (Üstte her zaman görünür)**
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("✅ Doğru: ${controller.correctAnswers.value}",
                          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.green)),
                      SizedBox(width: 20),
                      Text("❌ Yanlış: ${controller.wrongAnswers.value}",
                          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.red)),
                    ],
                  ),
                  SizedBox(height: pageHeight * 0.02),

                  // **Resim ve Geri Bildirim Mesajı**
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Image.memory(
                        base64Decode(controller.questions[controller.currentIndex.value]['imageBase64']),
                        width: pageWidth * 0.7,
                        height: pageHeight * 0.3,
                      ),
                      if (controller.testCompleted.value) // **Test tamamlandığında mesaj göster**
                        Positioned(
                          top: pageHeight * 0.05,
                          child: Container(
                            width: pageWidth * 0.9,
                            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                            decoration: BoxDecoration(
                              color: Colors.blue.withOpacity(0.7),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              "🏆 Test tamamlandı!", // **Sadece bu mesaj gösterilecek**
                              style: TextStyle(fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                    ],
                  ),
                  SizedBox(height: pageHeight * 0.05),

                  // **Şıklar - Kullanıcı seçim yaptıysa butonlar devre dışı**
                  Column(
                    children: List.generate(3, (index) {
                      String choice = controller.questions[index % controller.questions.length]['text'];
                      return Obx(() => ElevatedButton(
                        onPressed: controller.isAnswered.value ? null : () => controller.checkAnswer(choice), 
                        child: Text(choice, style: TextStyle(fontSize: 20)),
                      ));
                    }),
                  ),
                ],
              )),
      ),
    );
  }
}