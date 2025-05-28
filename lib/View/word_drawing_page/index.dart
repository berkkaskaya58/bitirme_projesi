import 'package:bitirme_projesi/Utils/drawing_utils/index.dart';
import 'package:bitirme_projesi/widgets/action_buttons/index.dart';
import 'package:bitirme_projesi/widgets/drawing_canvas/index.dart';
import 'package:bitirme_projesi/widgets/eraser_size_dialog/index.dart';
import 'package:bitirme_projesi/widgets/feedback_icon/index.dart';
import 'package:bitirme_projesi/widgets/tool_panel/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';


class WritingPage extends StatefulWidget {
  const WritingPage({super.key});

  @override
  State<WritingPage> createState() => _WritingPageState();
}

class _WritingPageState extends State<WritingPage> with TickerProviderStateMixin {
  final GlobalKey _paintKey = GlobalKey();
  List<List<Offset?>> _paths = [[]];
  int _pathIndex = 0;
  bool _isCorrect = false;
  final List<String> _wordList = ['elma', 'masa', 'okul'];
  int _currentIndex = 0;

  Color _penColor = Colors.black;
  double _penWidth = 4.0;
  bool _isEraser = false;
  double _eraserSize = 12.0;

  FlutterTts flutterTts = FlutterTts();
  AnimationController? _animationController;
  String _animatedText = '';

  @override
  void initState() {
    super.initState();
    _initTTS();
    _startLetterAnimation();
  }

  void _initTTS() async {
    await flutterTts.setLanguage("tr-TR");
    await flutterTts.setSpeechRate(0.4);
    await flutterTts.setPitch(1.0);
  }

  void _speakWord(String word) {
    flutterTts.speak("Lütfen şu kelimeyi yaz: $word");
  }

  void _startLetterAnimation() {
    final word = _wordList[_currentIndex];
    _animatedText = '';
    _animationController?.dispose();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: word.length * 600),
    )..addListener(() {
      final int currentLetter = (_animationController!.value * word.length).floor();
      if (currentLetter < word.length) {
        setState(() {
          _animatedText = word.substring(0, currentLetter + 1);
        });
      }
    })..forward();
    _speakWord(word);
  }

  void _clearDrawing() {
    setState(() {
      _paths = [[]];
      _pathIndex = 0;
      _isCorrect = false;
    });
    _startLetterAnimation();
  }

  void _nextWord() {
    setState(() {
      _currentIndex = (_currentIndex + 1) % _wordList.length;
      _clearDrawing();
    });
  }

  void _previousWord() {
    setState(() {
      _currentIndex = (_currentIndex - 1 + _wordList.length) % _wordList.length;
      _clearDrawing();
    });
  }

  void _checkIfCorrect(Size size) {
    if (isDrawingCorrect(_paths, size)) {
      setState(() => _isCorrect = true);
      flutterTts.speak("Harika! Doğru yazdın");
    }
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
    final targetWord = _wordList[_currentIndex];

    return Scaffold(
      appBar: AppBar(title: const Text('Kelime Yazma'), backgroundColor: Colors.green.shade700),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: DrawingCanvas(
                  key: _paintKey,
                  paths: _paths,
                  pathIndex: _pathIndex,
                  penColor: _penColor,
                  penWidth: _penWidth,
                  eraserSize: _eraserSize,
                  isEraser: _isEraser,
                  animatedText: _animatedText,
                  isCorrect: _isCorrect,
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
                  onPanEnd: (size) => _checkIfCorrect(size),
                ),
              ),
              ActionButtons(
                onNext: _nextWord,
                onPrevious: _previousWord,
                onUndo: _undo,
                onRedo: _redo,
              ),
            ],
          ),
          ToolPanel(
            penColor: _penColor,
            isEraser: _isEraser,
            eraserSize: _eraserSize,
            onPenSelected: _togglePen,
            onEraserSelected: () => showEraserSizeDialog(context, _eraserSize, (v) {
              setState(() => _eraserSize = v);
              _toggleEraser();
            }),
          ),
          if (_isCorrect) const FeedbackIcon(),
        ],
      ),
    );
  }
}