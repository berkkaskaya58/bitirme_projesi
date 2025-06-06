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
            ? const CircularProgressIndicator()
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // **Doğru - Yanlış Sayaçları (Üstte her zaman görünür)**
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("✅ Doğru: ${controller.correctAnswers.value}",
                          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.green)),
                      const SizedBox(width: 20),
                      Text("❌ Yanlış: ${controller.wrongAnswers.value}",
                          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.red)),
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
                            width: pageWidth * 0.95,
                            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                            decoration: BoxDecoration(
                              color: Colors.blue.withOpacity(0.7),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Text(
                              "🏆 Test tamamlandı!", // **Sadece bu mesaj gösterilecek**
                              style: TextStyle(fontSize: 28, color: Colors.white, fontWeight: FontWeight.bold),
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
                      return Obx(() => ElevatedButton(
                        onPressed: controller.isAnswered.value ? null : () => controller.checkAnswer(controller.currentChoices[index]), 
                        child: Text(controller.currentChoices[index], style: const TextStyle(fontSize: 20)),
                      ));
                    }),
                  ),
                ],
              )),
      ),
    );
  }
}