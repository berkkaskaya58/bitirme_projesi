import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WordAnimationScreen(),
    );
  }
}

class WordAnimationScreen extends StatefulWidget {
  @override
  _WordAnimationScreenState createState() => _WordAnimationScreenState();
}

class _WordAnimationScreenState extends State<WordAnimationScreen> {
  List<String> words = [];
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    fetchWords();
  }

  // Firestore'dan tüm kelimeleri çek
  Future<void> fetchWords() async {
    var querySnapshot = await FirebaseFirestore.instance.collection("words").get();
    setState(() {
      words = querySnapshot.docs.map((doc) => doc.data()?["text"] as String).toList();
    });

    print("Çekilen kelimeler: $words");
  }

  // Bir sonraki kelimeye geç
  void nextWord() {
    if (currentIndex < words.length - 1) {
      setState(() {
        currentIndex++;
      });
    }
  }

  // Bir önceki kelimeye geç
  void previousWord() {
    if (currentIndex > 0) {
      setState(() {
        currentIndex--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Harf Harf Animasyonlu Kelime Yazdırma")),
      body: Center(
        child: words.isEmpty
            ? CircularProgressIndicator()
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnimatedTextKit(
                    key: ValueKey<String>(words[currentIndex]), // Kelime değiştiğinde widget değişsin!
                    animatedTexts: [
                      TypewriterAnimatedText(
                        words[currentIndex],
                        textStyle: TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold),
                        speed: Duration(milliseconds: 200),
                      ),
                    ],
                    totalRepeatCount: 1,
                    displayFullTextOnTap: true,
                    stopPauseOnTap: true,
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_back, size: 40),
                        onPressed: previousWord,
                      ),
                      SizedBox(width: 20),
                      IconButton(
                        icon: Icon(Icons.arrow_forward, size: 40),
                        onPressed: nextWord,
                      ),
                    ],
                  ),
                ],
              ),
      ),
    );
  }
}
