import 'package:bitirme_projesi/View/word_drawing_page/index.dart';
import 'package:bitirme_projesi/View/word_test_page/index.dart';
import 'package:bitirme_projesi/View/words_page/index.dart';
import 'package:bitirme_projesi/controller/homePage_contoller/index.dart';
import 'package:bitirme_projesi/ui/ui_images/index.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bitirme_projesi/ui/ui_icon/index.dart';
import 'package:bitirme_projesi/ui/ui_text/index.dart';
import 'package:bitirme_projesi/ui/ui_voice/index.dart';
import 'package:bitirme_projesi/widgets/custom_button/index.dart';

class WordsHomePage extends StatelessWidget {
  const WordsHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomePageController());

    double pageWidth = MediaQuery.of(context).size.width;
    double pageHeight = MediaQuery.of(context).size.height;
    double buttonWidth = pageWidth * 0.8;
    double buttonHeight = pageHeight * 0.07;

    return Scaffold(
      body: Center(
        child: SafeArea(
          child: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: pageWidth*0.05,top: pageHeight*0.01
                      ),
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back, size: 30),
                    onPressed: () {
                      Get.back(); // Önceki sayfaya dönüş
                    },
                  ),
                ),
              ),
              SizedBox(
                width: pageWidth * 0.95, // Görselin genişliğini ayarla
                height: pageHeight * 0.45, // Görselin yüksekliğini ayarla
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(200),
                  child: Image.asset(
                    UIImage.yaslilar,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: buttonHeight / 1.3),
              CustomButton(
                width: buttonWidth,
                height: buttonHeight,
                title: UIText.words,
                icon: UIIcon.volume,
                onIconTap: () => controller.playVoice(UIVoices.kelimeler),
                func: () {
                  Get.to(WordsPage(),
                      transition: Transition.cupertino,
                      duration: const Duration(milliseconds: 800));
                },
              ),
              const SizedBox(height: 20),
              CustomButton(
                width: buttonWidth,
                height: buttonHeight,
                title: UIText.wordDrawing,
                icon: UIIcon.volume,
                onIconTap: () => controller.playVoice(UIVoices.heceler),
                func: () {
                  Get.to(WordAnimationScreen());
                },
              ),
              const SizedBox(height: 20),
              CustomButton(
                width: buttonWidth,
                height: buttonHeight,
                title: UIText.test,
                icon: UIIcon.volume,
                func: () {
                  Get.to(TestPage());
                },
                onIconTap: () => controller.playVoice(UIVoices.harfler),
              ),
              const SizedBox(height: 20),
              
            ],
          ),
        ),
      ),
    );
  }
}
