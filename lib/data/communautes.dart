import 'package:flutter/material.dart';

class CommunautePage extends StatelessWidget {
  final String nom;
  final String description;
  final IconData icone;
  final Color couleur;

  const CommunautePage({
    super.key,
    required this.nom,
    required this.description,
    required this.icone,
    required this.couleur,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: couleur,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: BackButton(color: Colors.white),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icone, size: 100, color: Colors.white),
              const SizedBox(height: 30),
              Text(
                "Bienvenue dans la communauté $nom !",
                style: const TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Text(
                description,
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.white70,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// 🔥 Fonction de redirection selon la communauté
Widget getPageParCommunaute(String nom) {
  switch (nom) {
    case "Soleil":
      return const CommunautePage(
        nom: "Soleil ☀️",
        description: "Tu es lumineux(se), joyeux(se) et positif(ve).",
        icone: Icons.wb_sunny,
        couleur: Color(0xFFFFCA28),
      );
    case "Pluie":
      return const CommunautePage(
        nom: "Pluie 🌧",
        description: "Tu ressens un peu de mélancolie ou de fatigue.",
        icone: Icons.water_drop,
        couleur: Color(0xFF64B5F6),
      );
    case "Vent":
      return const CommunautePage(
        nom: "Vent 💨",
        description: "Tu sembles stressé(e), agité(e) ou dispersé(e).",
        icone: Icons.wind_power,
        couleur: Color(0xFF5C6BC0),
      );
    case "Feu":
      return const CommunautePage(
        nom: "Feu 🔥",
        description: "Tu es intense, passionné(e) ou en colère.",
        icone: Icons.local_fire_department,
        couleur: Color(0xFFEF5350),
      );
    default:
      return const Scaffold(
        body: Center(child: Text("Communauté inconnue")),
      );
  }
}