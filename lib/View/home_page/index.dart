import 'package:bitirme_projesi/View/settings_page/index.dart';
import 'package:bitirme_projesi/ui/ui_text/index.dart';
import 'package:bitirme_projesi/widgets/custom_button/index.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Sayfanın genişliğini ve yüksekliğini alıyoruz
    double pageWidth = MediaQuery.of(context).size.width; // Sayfa genişliği
    double pageHeight = MediaQuery.of(context).size.height; // Sayfa yüksekliği

    // Butonlar için boyutları ayarlıyoruz
    double buttonWidth = pageWidth * 0.8; // Buton genişliği: Sayfanın %80'i
    double buttonHeight = pageHeight*0.07; // Sabit buton yüksekliği

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(UIText.homePage),
      ),
      body: Center( // Butonları ekranın ortasında hizalamak için Center widget'ı kullandık
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20), // Padding ekledik
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // Butonları dikeyde ortalamak
            crossAxisAlignment: CrossAxisAlignment.center, // Butonları yatayda ortalamak
            children: [
              // Her butona sabit boyutlar veriyoruz
              CustomButton(
                width: buttonWidth,
                height: buttonHeight,
                title: UIText.words,
              ),
              const SizedBox(height: 20), // Butonlar arasında boşluk
              CustomButton(
                width: buttonWidth,
                height: buttonHeight,
                title: UIText.syllables,
              ),
              const SizedBox(height: 20), // Butonlar arasında boşluk
              CustomButton(
                width: buttonWidth,
                height: buttonHeight,
                title: UIText.letters,
               
              ),
              const SizedBox(height: 20), // Butonlar arasında boşluk
              CustomButton(
                func: () {
                  Get.to(SettingsPage(),transition: Transition.cupertino,duration: Duration(milliseconds: 800));
                },
                width: buttonWidth,
                height: buttonHeight,
                title: UIText.settings,
              ),
            ],
          ),
        ),
      ),
    );
  }
}