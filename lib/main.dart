import 'package:bitirme_projesi/View/home_page/index.dart';
import 'package:bitirme_projesi/View/onboarding_page/index.dart';
import 'package:bitirme_projesi/controller/onboarding_controller/index.dart';
import 'package:bitirme_projesi/controller/theme_controller/index.dart';
import 'package:bitirme_projesi/firebase_options.dart';
import 'package:bitirme_projesi/size_controller/index.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Controller'ları başlat
  Get.put(ThemeController());
  Get.put(TextSizeController());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    final onboardingController = Get.put(OnboardingController());
    onboardingController.isFirstTime.value = true;

    return Obx(() => GetMaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            brightness: Brightness.light,
            scaffoldBackgroundColor: const Color.fromARGB(255, 250, 201, 129),
            appBarTheme: const AppBarTheme(
              backgroundColor: Color.fromARGB(255, 245, 189, 109),
              foregroundColor: Colors.black,
            ),
          ),
          darkTheme: ThemeData(
            brightness: Brightness.dark,
            scaffoldBackgroundColor: const Color(0xFF121212),
            appBarTheme: const AppBarTheme(
              backgroundColor: Color(0xFF1F1F1F),
              foregroundColor: Colors.white,
            ),
          ),
          themeMode: themeController.isDarkMode.value
              ? ThemeMode.dark
              : ThemeMode.light,
          home: onboardingController.isFirstTime.value
              ? OnboardingPage()
              : const HomePage(),
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