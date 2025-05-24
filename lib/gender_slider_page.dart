import 'package:flutter/material.dart';
import 'services/emotion_test_page.dart';

class GenderSliderPage extends StatefulWidget {
  const GenderSliderPage({super.key});

  @override
  State<GenderSliderPage> createState() => _GenderSliderPageState();
}

class _GenderSliderPageState extends State<GenderSliderPage> {
  double _sliderValue = 0; // 0 = Homme, 1 = Femme

  @override
  Widget build(BuildContext context) {
    final bool isHomme = _sliderValue < 0.5;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/gender-background.png'),
            fit: BoxFit.cover,
            alignment: Alignment.bottomLeft,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
            child: Column(
              children: [
                const SizedBox(height: 20),
                const Text(
                  "Quel est ton genre ?",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1F8057),
                  ),
                ),
                const SizedBox(height: 40),

                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 400),
                  transitionBuilder: (child, animation) => FadeTransition(
                    opacity: animation,
                    child: child,
                  ),
                  child: Image.asset(
                    isHomme
                        ? 'assets/images/home.png'
                        : 'assets/images/femme.png',
                    key: ValueKey(isHomme ? 'homme' : 'femme'),
                    height: 250,
                  ),
                ),

                const SizedBox(height: 40),

                // 🔄 Slider fluide
                SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 10),
                    overlayShape: const RoundSliderOverlayShape(overlayRadius: 20),
                  ),
                  child: Slider(
                    value: _sliderValue,
                    min: 0,
                    max: 1,
                    onChanged: (value) {
                      setState(() {
                        _sliderValue = value;
                      });
                    },
                    activeColor: const Color(0xFF1F8057),
                    inactiveColor: const Color(0xFFA6DF7E),
                  ),
                ),

                // 🚻 Texte en dessous avec effet de sélection
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Homme",
                      style: TextStyle(
                        fontSize: 16,
                        color: isHomme ? const Color(0xFF1F8057) : Colors.grey,
                        fontWeight: isHomme ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                    Text(
                      "Femme",
                      style: TextStyle(
                        fontSize: 16,
                        color: !isHomme ? const Color(0xFF1F8057) : Colors.grey,
                        fontWeight: !isHomme ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                  ],
                ),

                const Spacer(),

                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const EmotionTestPage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1F8057),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    minimumSize: const Size.fromHeight(50),
                  ),
                  child: const Text("Continuer", style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}