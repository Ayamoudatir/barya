import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE6F4EA),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1F8057),
        title: const Text('Bienvenue sur Barya'),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/logo-orig.png', width: 120),
              const SizedBox(height: 30),
              const Text(
                'Tu es bien connecté(e) !',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1F8057),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Bienvenue dans la communauté Barya. Tu peux maintenant explorer l\'application.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.black87),
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  // 👉 Redirige vers une autre page si tu veux
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFA6DF7E),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40),
                  ),
                  minimumSize: const Size.fromHeight(50),
                ),
                child: const Text(
                  'Continuer',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}