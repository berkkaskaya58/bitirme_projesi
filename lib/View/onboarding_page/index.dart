// lib/View/onboarding_page.dart
import 'package:bitirme_projesi/View/home_page/index.dart';
import 'package:bitirme_projesi/controller/onboarding_controller/index.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnboardingPage extends StatelessWidget {
  final controller = Get.find<OnboardingController>();

  final List<String> pages = [
    "Hoş geldin!",
    "Uygulamada kelime ve hece çalışmaları yapabilirsin.",
    "Ayarlar kısmından temayı ve yazı boyutunu değiştirebilirsin."
  ];

  final PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    RxInt currentPage = 0.obs;

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: pageController,
              itemCount: pages.length,
              onPageChanged: (index) => currentPage.value = index,
              itemBuilder: (_, index) => Center(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    pages[index],
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
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
                          margin: EdgeInsets.all(4),
                          width: 10,
                          height: 10,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: currentPage.value == i
                                  ? Colors.blue
                                  : Colors.grey),
                        )),
              )),
          SizedBox(height: 20),
          Obx(() => currentPage.value == pages.length - 1
              ? ElevatedButton(
                  onPressed: () {
                    controller.completeOnboarding();
                    Get.offAll(() => HomePage());
                  },
                  child: Text("Başla"),
                )
              : TextButton(
                  onPressed: () {
                    pageController.nextPage(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeInOut);
                  },
                  child: Text("İleri"),
                )),
          SizedBox(height: 20)
        ],
      ),
    );
  }
}