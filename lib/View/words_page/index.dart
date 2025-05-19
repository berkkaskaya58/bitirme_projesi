import 'dart:typed_data';
import 'package:bitirme_projesi/controller/wordsPage_controller/index.dart';
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
      body: Obx(
        () => controller.words.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : Stack(
                children: [
                  Positioned(
                    top: pageHeight * 0.07,
                    left: pageWidth * 0.03,
                    child: GestureDetector(
                      onTap: () {
                        print("Geri butonuna tıklandı!");
                        Get.back();
                      },
                      child: Icon(Icons.arrow_back, size: 30, color: Colors.black),
                    ),
                  ),
                  PageView.builder(
                    controller: controller.pageController,
                    itemCount: controller.words.length,
                    itemBuilder: (context, index) {
                      String text = controller.words[index]['text'];
                      Uint8List imageBytes = base64Decode(controller.words[index]['imageBase64']);

                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.9,
                            height: 400,
                            child: Image.memory(imageBytes, fit: BoxFit.contain),
                          ),
                          SizedBox(height: 20),
                          Text(text, style: TextStyle(fontSize: 50)),
                          SizedBox(height: 40),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              IconButton(icon: Icon(Icons.arrow_back, size: 40), onPressed: controller.prevPage),
                              IconButton(icon: Icon(Icons.arrow_forward, size: 40), onPressed: controller.nextPage),
                            ],
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
      ),
    );
  }
}
