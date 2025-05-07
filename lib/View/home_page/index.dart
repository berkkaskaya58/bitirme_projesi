import 'package:bitirme_projesi/controller/homePage_contoller/index.dart';
import 'package:bitirme_projesi/ui/ui_images/index.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bitirme_projesi/View/settings_page/index.dart';
import 'package:bitirme_projesi/ui/ui_icon/index.dart';
import 'package:bitirme_projesi/ui/ui_text/index.dart';
import 'package:bitirme_projesi/widgets/custom_button/index.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomePageController());

    double pageWidth = MediaQuery.of(context).size.width;
    double pageHeight = MediaQuery.of(context).size.height;
    double buttonWidth = pageWidth * 0.8;
    double buttonHeight = pageHeight * 0.07;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 250, 201, 129),
      body: Center(
        child: SafeArea(
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(200),
                child: Image.asset(UIImage.yaslilar)),

                SizedBox(height:buttonHeight/1.3,),
              CustomButton(
                width: buttonWidth,
                height: buttonHeight,
                title: UIText.words,
                icon: UIIcon.volume,
                onIconTap: () => controller.speakText(UIText.words),
              ),
              const SizedBox(height: 20),
              CustomButton(
                width: buttonWidth,
                height: buttonHeight,
                title: UIText.syllables,
                icon: UIIcon.volume,
                onIconTap: () => controller.speakText(UIText.syllables),
              ),
              const SizedBox(height: 20),
              CustomButton(
                width: buttonWidth,
                height: buttonHeight,
                title: UIText.letters,
                icon: UIIcon.volume,
                onIconTap: () => controller.speakText(UIText.letters),
              ),
              const SizedBox(height: 20),
              CustomButton(
                width: buttonWidth,
                height: buttonHeight,
                title: UIText.settings,
                icon: UIIcon.volume,
                onIconTap: () => controller.speakText(UIText.settings),
                func: () {
                  Get.to(SettingsPage(),
                      transition: Transition.cupertino,
                      duration: const Duration(milliseconds: 800));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
