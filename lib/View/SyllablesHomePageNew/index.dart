import 'package:bitirme_projesi/View/SyllablesPage/index.dart';
import 'package:bitirme_projesi/View/home_page_new/index.dart';
import 'package:bitirme_projesi/View/syllablesTest/index.dart';
import 'package:bitirme_projesi/controller/homePage_contoller/index.dart';
import 'package:bitirme_projesi/ui/ui_voice/index.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class SyllablesHomePage extends StatefulWidget {
  const SyllablesHomePage({super.key});

  @override
  State<SyllablesHomePage> createState() => _SyllablesHomePageState();
}

class _SyllablesHomePageState extends State<SyllablesHomePage> {
  final homeController = Get.put(HomePageController());
  int _currentIndex = 0;

  final List<Widget> _pages = [
   /*  WordsPage(), */
    SyllablesPage(),
    SyllablesTestPage(),
    /* TestPage(), */
  ];

  @override
  Widget build(BuildContext context) {
    double pageWidth = MediaQuery.of(context).size.width;
    double pageHeight = MediaQuery.of(context).size.height;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDarkMode ? Colors.black : Colors.white,
      body: Stack(
        children: [
          _pages[_currentIndex],
          Positioned(
            top: pageHeight * 0.03,
            left: pageWidth * 0.04,
            child: IconButton(
              icon: Icon(
                Icons.arrow_back,
                size: 30,
                color: isDarkMode ? Colors.white : Colors.black,
              ),
              onPressed: () => Get.to(() => const HomePage(), transition: Transition.cupertino,
                  duration: const Duration(milliseconds: 700)),
            ),
          ),
        ],
      ),
      bottomNavigationBar: SalomonBottomBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() => _currentIndex = index);

          if (index == 0) {
            homeController.playVoice(UIVoices.heceler);
          } else if (index == 1) {
            homeController.playVoice(UIVoices.alistirma);
          }
        },
        items: [
         /*  SalomonBottomBarItem(
            icon: const Icon(Icons.book),
            title: const Text("Kelimeler"),
            selectedColor: Colors.orange,
          ), */
          SalomonBottomBarItem(
            icon: const Icon(Icons.draw),
            title: const Text("Heceler"),
            selectedColor: Colors.teal,
          ),
           SalomonBottomBarItem(
            icon: const Icon(Icons.person_pin_circle),
            title: const Text("Test"),
            selectedColor: Colors.teal,
          ),
         /*  SalomonBottomBarItem(
            icon: const Icon(Icons.quiz_outlined),
            title: const Text("alıştırma"),
            selectedColor: Colors.blue,
          ), */
        ],
      ),
    );
  }
}
