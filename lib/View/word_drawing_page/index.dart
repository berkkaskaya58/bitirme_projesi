import 'package:bitirme_projesi/controller/writing_controller/index.dart';
import 'package:bitirme_projesi/Utils/drawing_utils/index.dart';
import 'package:bitirme_projesi/widgets/drawing_canvas/index.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WritingPage extends StatefulWidget {
  const WritingPage({super.key});

  @override
  State<WritingPage> createState() => _WritingPageState();
}

class _WritingPageState extends State<WritingPage> {
  final WritingController controller = Get.put(WritingController());
  final GlobalKey _paintKey = GlobalKey();
  List<List<Offset?>> _paths = [[]];
  int _pathIndex = 0;
  Color _penColor = Colors.black;
  double _penWidth = 4.0;
  bool _isEraser = false;
  double _eraserSize = 12.0;

  void _clearDrawing() {
    setState(() {
      _paths = [[]];
      _pathIndex = 0;
    });
  }

  void _undo() {
    if (_pathIndex > 0) setState(() => _pathIndex--);
  }

  void _redo() {
    if (_pathIndex < _paths.length - 1) setState(() => _pathIndex++);
  }

  void _togglePen(Color newColor) {
    setState(() {
      _penColor = newColor;
      _isEraser = false;
    });
  }

  void _toggleEraser() {
    setState(() => _isEraser = true);
  }

  @override
  Widget build(BuildContext context) {
    double pageWidth = MediaQuery.of(context).size.width;
    double pageHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Kelime Yazma'),
        backgroundColor: Colors.teal,
      ),
      body: Obx(() {
        // Kelime değiştiğinde çizimi temizle
        if (controller.clearDrawing.value) {
          _clearDrawing();
          controller.drawingCleared();
        }

        return controller.words.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : Stack(
                children: [
                  Column(
                    children: [
                      // Kelime Gösterimi
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Text(
                          controller.words[controller.currentIndex.value]['text'],
                          style: TextStyle(
                            fontSize: pageHeight * 0.05,
                            fontWeight: FontWeight.bold,
                            color: Colors.teal,
                          ),
                        ),
                      ),
                      // Çizim Alanı
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.teal, width: 2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: DrawingCanvas(
                            key: _paintKey,
                            paths: _paths,
                            pathIndex: _pathIndex,
                            penColor: _penColor,
                            penWidth: _penWidth,
                            eraserSize: _eraserSize,
                            isEraser: _isEraser,
                            animatedText: controller.animatedText.value,
                            isCorrect: controller.isCorrect.value,
                            onPanStart: () {
                              if (_pathIndex != _paths.length - 1) {
                                _paths = _paths.sublist(0, _pathIndex + 1);
                              }
                              _paths.add([]);
                              _pathIndex++;
                            },
                            onPanUpdate: (offset) {
                              setState(() {
                                _paths[_pathIndex].add(offset);
                              });
                            },
                            onPanEnd: (size) {
                              bool isCorrect = DrawingUtils.isDrawingCorrect(
                                _paths,
                                size,
                                controller.words[controller.currentIndex.value]['text']
                              );
                              controller.checkAnswer(isCorrect);
                            },
                          ),
                        ),
                      ),
                      // Kontrol Butonları
                      Container(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.arrow_back),
                              onPressed: controller.previousWord,
                              color: Colors.teal,
                            ),
                            IconButton(
                              icon: const Icon(Icons.undo),
                              onPressed: _undo,
                              color: Colors.teal,
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: _clearDrawing,
                              color: Colors.teal,
                            ),
                            IconButton(
                              icon: const Icon(Icons.redo),
                              onPressed: _redo,
                              color: Colors.teal,
                            ),
                            IconButton(
                              icon: const Icon(Icons.arrow_forward),
                              onPressed: controller.nextWord,
                              color: Colors.teal,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  // Araç Çubuğu
                  Positioned(
                    right: 16,
                    top: pageHeight * 0.2,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () => _togglePen(Colors.black),
                            color: _isEraser ? Colors.grey : Colors.black,
                          ),
                          IconButton(
                            icon: const Icon(Icons.color_lens),
                            onPressed: () => _togglePen(Colors.blue),
                            color: _isEraser ? Colors.grey : Colors.blue,
                          ),
                          IconButton(
                            icon: const Icon(Icons.brush),
                            onPressed: () => _togglePen(Colors.red),
                            color: _isEraser ? Colors.grey : Colors.red,
                          ),
                          IconButton(
                            icon: const Icon(Icons.cleaning_services),
                            onPressed: _toggleEraser,
                            color: _isEraser ? Colors.teal : Colors.grey,
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Sadece Doğru Cevap Göstergesi
                  if (controller.isAnswered.value && controller.isCorrect.value)
                    Positioned(
                      top: pageHeight * 0.1,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Text(
                            "✅ Harika!",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              );
      }),
    );
  }
}