import 'package:bitirme_projesi/View/word_drawing_page/index.dart';
import 'package:bitirme_projesi/View/word_test_page/index.dart';
import 'package:bitirme_projesi/View/words_page/index.dart';
import 'package:bitirme_projesi/controller/homePage_contoller/index.dart';
import 'package:bitirme_projesi/ui/ui_voice/index.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class WordsHomePage extends StatefulWidget {
  const WordsHomePage({super.key});

  @override
  State<WordsHomePage> createState() => _WordsHomePageState();
}

class _WordsHomePageState extends State<WordsHomePage> {
  final homeController = Get.put(HomePageController());
  int _currentIndex = 0;

  final List<Widget> _pages = [
    WordsPage(),
    WritingPage(),
    TestPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
  body: SafeArea(child: _pages[_currentIndex]),
  bottomNavigationBar: SalomonBottomBar(
    currentIndex: _currentIndex,
    onTap: (index) {
      setState(() => _currentIndex = index);

      if (index == 0) {
        homeController.playVoice(UIVoices.kelimeler);
      }if (index == 2) {
          homeController.playVoice(UIVoices.alistirma);
      }
    },
    items: [
      SalomonBottomBarItem(
        icon: const Icon(Icons.book),
        title: const Text("Kelimeler"),
        selectedColor: Colors.orange,
      ),
      SalomonBottomBarItem(
        icon: const Icon(Icons.draw),
        title: const Text("Kelime Çizme"),
        selectedColor: Colors.teal,
      ),
      SalomonBottomBarItem(
        icon: const Icon(Icons.quiz_outlined),
        title: const Text("alıştırma"),
        selectedColor: Colors.blue,
      ),
    ],
  ),
);

  }
}
