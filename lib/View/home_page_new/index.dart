import 'package:bitirme_projesi/View/SyllablesHomePage/index.dart';
import 'package:bitirme_projesi/View/words_home_page_new/index.dart';
import 'package:bitirme_projesi/controller/homePage_contoller/index.dart';
import 'package:bitirme_projesi/ui/ui_images/index.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bitirme_projesi/View/settings_page/index.dart';
import 'package:bitirme_projesi/ui/ui_icon/index.dart';
import 'package:bitirme_projesi/ui/ui_text/index.dart';
import 'package:bitirme_projesi/ui/ui_voice/index.dart';
import 'package:bitirme_projesi/widgets/custom_button/index.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomePageController());

    double pageWidth = MediaQuery.of(context).size.width;
    double pageHeight = MediaQuery.of(context).size.height;
    double buttonWidth = pageWidth * 0.9;
    double buttonHeight = pageHeight * 0.06;

    return Scaffold(
      body: Column(
        children: [
          Image.asset(
            UIImage.anaSayfa,
            width: pageWidth,
            height: pageHeight * 0.3,
            fit: BoxFit.cover,
          ),
          SizedBox(height: pageHeight * 0.02),
          Container(
            width: pageWidth,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            alignment: Alignment.center,
            child: Text(
              UIText.anasayfa1,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                height: 1.1,
                letterSpacing: -0.3,
              ),
            ),
          ),
          SizedBox(height: pageHeight * 0.01),
          Container(
            width: pageWidth,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            alignment: Alignment.center,
            child: Text(
              UIText.anaSayfa2,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          SizedBox(height: pageHeight * 0.05),
          CustomButton(
            width: buttonWidth,
            height: buttonHeight,
            title: UIText.words,
            icon: UIIcon.volume,
            onIconTap: () => controller.playVoice(UIVoices.kelimeler),
            func: () {
              Get.to(() => const WordsHomePage(),
                  transition: Transition.cupertino,
                  duration: const Duration(milliseconds: 500));
            },
          ),
          SizedBox(height: pageHeight * 0.015),
          CustomButton(
            width: buttonWidth,
            height: buttonHeight,
            title: UIText.syllables,
            icon: UIIcon.volume,
            onIconTap: () => controller.playVoice(UIVoices.heceler),
            func: () {
              Get.to(() => const SyllablesHomePage(),
                  transition: Transition.cupertino,
                  duration: const Duration(milliseconds: 800));
            },
          ),
          SizedBox(height: pageHeight * 0.015),
          CustomButton(
            width: buttonWidth,
            height: buttonHeight,
            title: UIText.letters,
            icon: UIIcon.volume,
            onIconTap: () => controller.playVoice(UIVoices.harfler),
            func: () {
              Get.to(() => const WordsHomePage(),
                  transition: Transition.cupertino,
                  duration: const Duration(milliseconds: 800));
            },
          ),
          SizedBox(height: pageHeight * 0.015 ),
          CustomButton(
            width: buttonWidth,
            height: buttonHeight,
            title: UIText.settings,
            icon: UIIcon.volume,
            onIconTap: () => controller.playVoice(UIVoices.ayarlar),
            func: () {
              Get.to(
                () => SettingsPage(),
                transition: Transition.cupertino,
                duration: const Duration(milliseconds: 500),
              );
            },
          ),
        ],
      ),
    );
  }
}