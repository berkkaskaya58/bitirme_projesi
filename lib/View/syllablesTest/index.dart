import 'package:bitirme_projesi/controller/SyllablesPageController/index.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_tts/flutter_tts.dart';

class SyllablesTestPage extends StatefulWidget {
  @override
  _SyllablesTestPageState createState() => _SyllablesTestPageState();
}

class _SyllablesTestPageState extends State<SyllablesTestPage> {
  final SyllablesPageController controller = Get.put(SyllablesPageController());
  final FlutterTts flutterTts = FlutterTts();
  
  int currentWordIndex = 0;
  List<String> shuffledSyllables = [];
  List<String> selectedSyllables = [];
  String userAnswer = '';
  bool isCorrect = false;
  bool showResult = false;

  @override
  void initState() {
    super.initState();
    // İlk kelimeyi yükle
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (controller.words.isNotEmpty) {
        loadNewWord();
      }
    });
  }

  void loadNewWord() {
    if (currentWordIndex < controller.words.length) {
      String syllables = controller.words[currentWordIndex]['syllables'];
      shuffledSyllables = syllables.split('-')..shuffle();
      selectedSyllables = [];
      userAnswer = '';
      isCorrect = false;
      showResult = false;
      setState(() {});
    }
  }

  void checkAnswer() {
    String correctAnswer = controller.words[currentWordIndex]['originalText'];
    isCorrect = userAnswer.toLowerCase() == correctAnswer.toLowerCase();
    showResult = true;
    setState(() {});
  }

  void nextWord() {
    if (currentWordIndex < controller.words.length - 1) {
      currentWordIndex++;
      loadNewWord();
    }
  }

  void speakWord() async {
    await flutterTts.setLanguage("tr-TR");
    await flutterTts.setSpeechRate(0.4);
    String syllables = controller.words[currentWordIndex]['syllables'];
    List<String> heceler = syllables.split('-');
    for (var hece in heceler) {
      await flutterTts.speak(hece.trim());
      await Future.delayed(Duration(milliseconds: 600));
    }
  }

  @override
  Widget build(BuildContext context) {
    double pageWidth = MediaQuery.of(context).size.width;
    double pageHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Heceleri Birleştir'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.volume_up),
            onPressed: speakWord,
          ),
        ],
      ),
      body: Obx(() {
        if (controller.words.isEmpty) {
          return const Center(child: CircularProgressIndicator(color: Colors.teal));
        }

        if (currentWordIndex >= controller.words.length) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.check_circle, size: pageWidth * 0.25, color: Colors.teal),
                SizedBox(height: pageHeight * 0.02),
                Text(
                  'Tebrikler! Tüm kelimeleri tamamladınız!',
                  style: TextStyle(fontSize: pageWidth * 0.06, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: pageHeight * 0.04),
                ElevatedButton(
                  onPressed: () {
                    currentWordIndex = 0;
                    loadNewWord();
                  },
                  child: Text('Tekrar Başla', style: TextStyle(fontSize: pageWidth * 0.04)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: pageWidth * 0.08, vertical: pageHeight * 0.02),
                  ),
                ),
              ],
            ),
          );
        }

        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.teal.shade50, Colors.white],
            ),
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(pageWidth * 0.05),
              child: Column(
                children: [
                  // İlerleme göstergesi
                  LinearProgressIndicator(
                    value: (currentWordIndex + 1) / controller.words.length,
                    backgroundColor: Colors.teal.shade200,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.teal),
                  ),
                  SizedBox(height: pageHeight * 0.02),
                  Text(
                    '${currentWordIndex + 1} / ${controller.words.length}',
                    style: TextStyle(fontSize: pageWidth * 0.045, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: pageHeight * 0.04),

                  // Kullanıcının cevabı
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(pageWidth * 0.05),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(pageWidth * 0.04),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 5,
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Text(
                          'Senin Cevabın:',
                          style: TextStyle(fontSize: pageWidth * 0.04, color: Colors.grey[600]),
                        ),
                        SizedBox(height: pageHeight * 0.01),
                        Container(
                          height: pageHeight * 0.08,
                          padding: EdgeInsets.all(pageWidth * 0.04),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(pageWidth * 0.025),
                            border: Border.all(color: Colors.teal.shade200),
                          ),
                          child: Wrap(
                            children: [
                              ...selectedSyllables.map((syllable) => 
                                Container(
                                  margin: EdgeInsets.only(right: pageWidth * 0.01),
                                  padding: EdgeInsets.symmetric(horizontal: pageWidth * 0.025, vertical: pageHeight * 0.006),
                                  decoration: BoxDecoration(
                                    color: Colors.teal.shade100,
                                    borderRadius: BorderRadius.circular(pageWidth * 0.02),
                                  ),
                                  child: Text(
                                    syllable,
                                    style: TextStyle(fontSize: pageWidth * 0.045, fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              if (selectedSyllables.isEmpty)
                                Text(
                                  'Heceleri seçin',
                                  style: TextStyle(color: Colors.grey[500], fontSize: pageWidth * 0.04),
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: pageHeight * 0.03),

                  // Mevcut heceler
                  Text(
                    'Heceleri Seç:',
                    style: TextStyle(fontSize: pageWidth * 0.045, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: pageHeight * 0.015),
                  Wrap(
                    spacing: pageWidth * 0.025,
                    runSpacing: pageHeight * 0.01,
                    children: shuffledSyllables.map((syllable) {
                      bool isSelected = selectedSyllables.contains(syllable);
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            if (isSelected) {
                              selectedSyllables.remove(syllable);
                            } else {
                              selectedSyllables.add(syllable);
                            }
                            userAnswer = selectedSyllables.join('');
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: pageWidth * 0.04, vertical: pageHeight * 0.012),
                          decoration: BoxDecoration(
                            color: isSelected ? Colors.teal : Colors.white,
                            borderRadius: BorderRadius.circular(pageWidth * 0.06),
                            border: Border.all(color: Colors.teal),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 1,
                                blurRadius: 3,
                              ),
                            ],
                          ),
                          child: Text(
                            syllable,
                            style: TextStyle(
                              fontSize: pageWidth * 0.045,
                              fontWeight: FontWeight.bold,
                              color: isSelected ? Colors.white : Colors.teal,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: pageHeight * 0.04),

                  // Kontrol butonu
                  if (!showResult)
                    ElevatedButton(
                      onPressed: selectedSyllables.isNotEmpty ? checkAnswer : null,
                      child: Text(
                        'Kontrol Et',
                        style: TextStyle(fontSize: pageWidth * 0.045),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(horizontal: pageWidth * 0.1, vertical: pageHeight * 0.018),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(pageWidth * 0.06),
                        ),
                      ),
                    ),

                  // Sonuç gösterimi
                  if (showResult) ...[
                    Container(
                      padding: EdgeInsets.all(pageWidth * 0.05),
                      decoration: BoxDecoration(
                        color: isCorrect ? Colors.green.shade50 : Colors.red.shade50,
                        borderRadius: BorderRadius.circular(pageWidth * 0.04),
                        border: Border.all(
                          color: isCorrect ? Colors.green : Colors.red,
                        ),
                      ),
                      child: Column(
                        children: [
                          Icon(
                            isCorrect ? Icons.check_circle : Icons.cancel,
                            size: pageWidth * 0.12,
                            color: isCorrect ? Colors.green : Colors.red,
                          ),
                          SizedBox(height: pageHeight * 0.01),
                          Text(
                            isCorrect ? 'Doğru!' : 'Yanlış!',
                            style: TextStyle(
                              fontSize: pageWidth * 0.06,
                              fontWeight: FontWeight.bold,
                              color: isCorrect ? Colors.green : Colors.red,
                            ),
                          ),
                          SizedBox(height: pageHeight * 0.01),
                          Text(
                            'Doğru cevap: ${controller.words[currentWordIndex]['originalText']}',
                            style: TextStyle(fontSize: pageWidth * 0.045),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: pageHeight * 0.02),
                    ElevatedButton(
                      onPressed: nextWord,
                      child: Text(
                        currentWordIndex < controller.words.length - 1 ? 'Sonraki Kelime' : 'Bitir',
                        style: TextStyle(fontSize: pageWidth * 0.045),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(horizontal: pageWidth * 0.1, vertical: pageHeight * 0.018),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(pageWidth * 0.06),
                        ),
                      ),
                    ),
                  ],
                  SizedBox(height: pageHeight * 0.02), // Alt boşluk
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
