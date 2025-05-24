import 'package:flutter/material.dart';
import '../data/communautes.dart';
// ✅ Ajout : importe la page principale
import '../user/main_page.dart';

class EmotionTestPage extends StatefulWidget {
  const EmotionTestPage({super.key});

  @override
  State<EmotionTestPage> createState() => _EmotionTestPageState();
}

class _EmotionTestPageState extends State<EmotionTestPage> {
  final PageController _controller = PageController();
  final List<double> _sliderValues = List.filled(4, 2);

  final List<String> questions = [
    "Quel visage te représente aujourd’hui ?",
    "Comment te sens-tu en tant qu’humain ?",
    "Quel élément naturel te correspond ?",
    "Quelle est ton humeur générale ?",
  ];

  final List<List<Map<String, dynamic>>> emotionSets = [
    [
      {'emoji': '😡', 'label': 'En colère', 'color': Color(0xFFE57373)},
      {'emoji': '😢', 'label': 'Triste', 'color': Color(0xFF64B5F6)},
      {'emoji': '😐', 'label': 'Neutre', 'color': Color(0xFFBDBDBD)},
      {'emoji': '🙂', 'label': 'Serein', 'color': Color(0xFFA5D6A7)},
      {'emoji': '🤩', 'label': 'Excité(e)', 'color': Color(0xFFBA68C8)},
    ],
    [
      {'emoji': '🧃', 'label': 'Fatigué(e)', 'color': Color(0xFF6D4C41)},
      {'emoji': '👨‍💻', 'label': 'Concentré(e)', 'color': Color(0xFF00ACC1)},
      {'emoji': '🧘', 'label': 'Posé(e)', 'color': Color(0xFF81C784)},
      {'emoji': '🏃', 'label': 'Actif(ve)', 'color': Color(0xFF4FC3F7)},
      {'emoji': '🕺', 'label': 'Énergique', 'color': Color(0xFFAB47BC)},
    ],
    [
      {'emoji': '🌪️', 'label': 'Agité(e)', 'color': Color(0xFF78909C)},
      {'emoji': '☔️', 'label': 'Mélancolique', 'color': Color(0xFF42A5F5)},
      {'emoji': '🌤️', 'label': 'Calme', 'color': Color(0xFF66BB6A)},
      {'emoji': '🌞', 'label': 'Rayonnant(e)', 'color': Color(0xFFFFCA28)},
      {'emoji': '🔥', 'label': 'Passionné(e)', 'color': Color(0xFFEF5350)},
    ],
    [
      {'emoji': '😓', 'label': 'Stressé(e)', 'color': Color(0xFF5C6BC0)},
      {'emoji': '😴', 'label': 'Lent(e)', 'color': Color(0xFF90A4AE)},
      {'emoji': '😌', 'label': 'Ok', 'color': Color(0xFF4DB6AC)},
      {'emoji': '😃', 'label': 'Content(e)', 'color': Color(0xFF66BB6A)},
      {'emoji': '😁', 'label': 'Au top', 'color': Color(0xFF7E57C2)},
    ],
  ];

  void _onContinue(int index) {
    if (index < questions.length - 1) {
      _controller.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    } else {
      _showSummary();
    }
  }

  void _showSummary() {
    final responses = List.generate(
      questions.length,
          (i) => emotionSets[i][_sliderValues[i].round()]['label'] as String,
    );

    final Map<String, int> scores = {
      'Soleil': 0,
      'Pluie': 0,
      'Vent': 0,
      'Feu': 0,
    };

    for (var label in responses) {
      if (["Serein", "Rayonnant(e)", "Content(e)", "Au top"].contains(label)) {
        scores['Soleil'] = scores['Soleil']! + 1;
      } else if (["Triste", "Fatigué(e)", "Mélancolique"].contains(label)) {
        scores['Pluie'] = scores['Pluie']! + 1;
      } else if (["Stressé(e)", "Agité(e)", "Lent(e)"].contains(label)) {
        scores['Vent'] = scores['Vent']! + 1;
      } else if (["En colère", "Excité(e)", "Passionné(e)"].contains(label)) {
        scores['Feu'] = scores['Feu']! + 1;
      }
    }

    // final String selectedCommunity = ... <- inutile maintenant

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => const MainPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: _controller,
      physics: const BouncingScrollPhysics(),
      itemCount: questions.length,
      itemBuilder: (context, index) {
        final currentValue = _sliderValues[index];
        final emotionSet = emotionSets[index];
        final currentEmotion = emotionSet[currentValue.round()];

        return Scaffold(
          backgroundColor: currentEmotion['color'],
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () async {
                if (_controller.page != null && _controller.page! > 0) {
                  await _controller.previousPage(
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.easeInOut,
                  );
                } else {
                  Navigator.pop(context);
                }
              },
            ),
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 50),
                  Text(
                    questions[index],
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 60),
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: Text(
                      currentEmotion['emoji'],
                      key: ValueKey<String>(currentEmotion['emoji']),
                      style: const TextStyle(fontSize: 120),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    currentEmotion['label'],
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  const Spacer(),
                  SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      thumbShape: LeafThumbShape(),
                      trackHeight: 6,
                      activeTrackColor: Colors.white,
                      inactiveTrackColor: Colors.white60,
                    ),
                    child: Slider(
                      value: currentValue,
                      min: 0,
                      max: (emotionSet.length - 1).toDouble(),
                      divisions: emotionSet.length - 1,
                      onChanged: (value) {
                        setState(() {
                          _sliderValues[index] = value;
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () => _onContinue(index),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: currentEmotion['color'],
                      minimumSize: const Size.fromHeight(50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: Text(
                      index < questions.length - 1 ? "Continuer" : "Terminer",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class LeafThumbShape extends SliderComponentShape {
  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) => const Size(40, 40);

  @override
  void paint(
      PaintingContext context,
      Offset center, {
        required Animation<double> activationAnimation,
        required Animation<double> enableAnimation,
        required bool isDiscrete,
        required TextPainter labelPainter,
        required RenderBox parentBox,
        required SliderThemeData sliderTheme,
        required TextDirection textDirection,
        required double value,
        required double textScaleFactor,
        required Size sizeWithOverflow,
      }) {
    final canvas = context.canvas;
    final Paint paint = Paint()..color = const Color(0xFF2E7D32);

    final Path path = Path()
      ..moveTo(center.dx, center.dy)
      ..cubicTo(center.dx - 10, center.dy - 20, center.dx + 10, center.dy - 20, center.dx, center.dy)
      ..cubicTo(center.dx + 10, center.dy + 20, center.dx - 10, center.dy + 20, center.dx, center.dy)
      ..close();

    canvas.drawShadow(path, Colors.black.withOpacity(0.3), 4, true);
    canvas.drawPath(path, paint);
  }
}