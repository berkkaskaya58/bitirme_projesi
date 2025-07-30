import 'package:bitirme_projesi/controller/AlphabetController/index.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_tts/flutter_tts.dart';

class AlphabetPage extends StatelessWidget {
  const AlphabetPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final controller = Get.put(AlphabetController());
    final FlutterTts flutterTts = FlutterTts();

    // Sesli ve sessiz harfler
    final List<String> vowels = ['A', 'E', 'I', 'İ', 'O', 'Ö', 'U', 'Ü'];
    final List<String> consonants = [
      'B', 'C', 'Ç', 'D', 'F', 'G', 'Ğ', 'H', 'J', 'K',
      'L', 'M', 'N', 'P', 'R', 'S', 'Ş', 'T', 'V', 'Y', 'Z'
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Harfler'),
        centerTitle: true,
       
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Sesli Harfler",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: theme.primary,
                ),
              ),
              const SizedBox(height: 12),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemCount: vowels.length,
                itemBuilder: (context, index) {
                  return _buildLetterCard(
                    context,
                    vowels[index],
                    theme.primaryContainer,
                    theme.primary.withOpacity(0.7),
                    controller,
                  );
                },
              ),
              const SizedBox(height: 32),
              Text(
                "Sessiz Harfler",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: theme.secondary,
                ),
              ),
              const SizedBox(height: 12),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemCount: consonants.length,
                itemBuilder: (context, index) {
                  return _buildLetterCard(
                    context,
                    consonants[index],
                    theme.secondaryContainer,
                    theme.secondary.withOpacity(0.7),
                    controller,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLetterCard(
      BuildContext context, String letter, Color color1, Color color2, AlphabetController controller) {
    final FlutterTts flutterTts = FlutterTts();
    return GestureDetector(
      onTap: () async {
        await flutterTts.setLanguage("tr-TR");
        await flutterTts.setSpeechRate(0.5);
        await flutterTts.speak(letter);
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Card(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              gradient: LinearGradient(
                colors: [color1, color2],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Center(
              child: Text(
                letter,
                style: const TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      offset: Offset(1, 1),
                      blurRadius: 2,
                      color: Colors.black26,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
