import 'package:bitirme_projesi/View/home_page/index.dart';
import 'package:bitirme_projesi/View/onboarding_page/index.dart';
import 'package:bitirme_projesi/controller/onboarding_controller/index.dart';
import 'package:bitirme_projesi/controller/theme_controller/index.dart';
import 'package:bitirme_projesi/size_controller/index.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Controller'ları başlat
  Get.put(ThemeController());
  Get.put(TextSizeController());

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    final onboardingController = Get.put(OnboardingController());
    onboardingController.isFirstTime.value = true;

    return Obx(() => GetMaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          themeMode: themeController.isDarkMode.value
              ? ThemeMode.dark
              : ThemeMode.light,
          home: onboardingController.isFirstTime.value
              ? OnboardingPage()
              : HomePage(),
          builder: (context, child) {
            final textSizeController = Get.find<TextSizeController>();
            return Obx(() => MediaQuery(
                  data: MediaQuery.of(context).copyWith(
                    textScaler:
                        TextScaler.linear(textSizeController.textScale.value),
                  ),
                  child: child!,
                ));
          },
        ));
  }
}
