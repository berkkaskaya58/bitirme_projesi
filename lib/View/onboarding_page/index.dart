import 'package:bitirme_projesi/View/home_page/index.dart';
import 'package:bitirme_projesi/controller/onboarding_controller/index.dart';
import 'package:bitirme_projesi/ui/ui_text/index.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnboardingPage extends StatelessWidget {
  final controller = Get.find<OnboardingController>();

  final List<String> pages = [
    "Hoş geldin!",
    "Uygulamada kelime ve hece çalışmaları yapabilirsin.",
    "Ayarlar kısmından temayı ve yazı boyutunu değiştirebilirsin.",
  ];

  final PageController pageController = PageController();

  OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    RxInt currentPage = 0.obs;

    // ✅ Sayfa ilk açıldığında sadece bir kere çalışır
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.playSound(0); // İlk sayfa sesi çalınsın
    });

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: pageController,
              itemCount: pages.length,
              onPageChanged: (index) {
                currentPage.value = index;
                controller.playSound(index); // Ses sadece 1 kere çalacak şekilde
              },
              itemBuilder: (_, index) => Center(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    pages[index],
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ),
          Obx(() => Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  pages.length,
                  (i) => Container(
                    margin: const EdgeInsets.all(4),
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: currentPage.value == i ? Colors.blue : Colors.grey,
                    ),
                  ),
                ),
              )),
          const SizedBox(height: 20),
          Obx(() => currentPage.value == pages.length - 1
              ? ElevatedButton(
                  onPressed: () {
                    controller.completeOnboarding();
                    Get.offAll(() => const HomePage(),
                        transition: Transition.cupertino,
                        duration: const Duration(milliseconds: 800));
                  },
                  child: Text(UIText.start),
                )
              : TextButton(
                  onPressed: () {
                    pageController.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  },
                  child: Text(UIText.next),
                )),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}