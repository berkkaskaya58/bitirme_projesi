import 'dart:typed_data';
import 'package:bitirme_projesi/controller/wordsPage_controller/index.dart';
import 'package:bitirme_projesi/ui/ui_icon/index.dart';
import 'package:bitirme_projesi/widgets/custom_button/index.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:convert';

class WordsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final WordsPageController controller = Get.put(WordsPageController());

    double pageWidth = MediaQuery.of(context).size.width;
    double pageHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
      ),
      body: Obx(
        () => controller.words.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : Stack(
                children: [
                  PageView.builder(
                    controller: controller.pageController,
                    itemCount: controller.words.length,
                    itemBuilder: (context, index) {
                      String text = controller.words[index]['text'];
                      Uint8List imageBytes =
                          base64Decode(controller.words[index]['imageBase64']);

                      return Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: pageWidth * 0.9,
                              height: pageHeight * 0.5,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.memory(imageBytes, fit: BoxFit.contain),
                              ),
                            ),
                            SizedBox(height: pageHeight * 0.03),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                              child: Text(
                                text,
                                style: TextStyle(
                                  fontSize: pageHeight * 0.05,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            SizedBox(height: pageHeight * 0.03),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                CustomButton(
                                   width: pageWidth / 5.5,
                                  height: pageHeight * 0.05,
                                  title: "",
                                  icon: UIIcon.back,
                                  func: controller.prevPage,
                                ),
                                CustomButton(
                                  width: pageWidth / 5.5,
                                  height: pageHeight * 0.05,
                                  title: "",
                                  icon: UIIcon.forward, 
                                  func: controller.nextPage,
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
      ),
    );
  }
}
