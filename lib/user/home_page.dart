import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Enlève le fond transparent
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          // 🌿 Image de fond
          SizedBox.expand(
            child: Image.asset(
              'assets/images/plante1.jpeg', // chemin vers ton image
              fit: BoxFit.cover,
            ),
          ),

          // 💚 Contenu avec transparence
          Column(
            children: [
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.85),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
                padding: const EdgeInsets.symmetric(vertical: 40),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    CircleAvatar(
                      radius: 45,
                      backgroundColor: Colors.white,
                      backgroundImage: AssetImage('assets/images/profile_placeholder.png'),
                    ),
                    SizedBox(height: 12),
                    Text(
                      "Bienvenue Aya ! 🌼",
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    SizedBox(height: 6),
                    Text(
                      "Comment te sens-tu aujourd'hui ?",
                      style: TextStyle(fontSize: 16, color: Colors.white70),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              Expanded(
                child: GridView.count(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  crossAxisCount: 2,
                  mainAxisSpacing: 24,
                  crossAxisSpacing: 24,
                  children: [
                    _DashboardButton(
                      icon: Icons.edit,
                      label: "Écrire",
                      onTap: () {},
                    ),
                    _DashboardButton(
                      icon: Icons.group,
                      label: "Amis",
                      onTap: () {},
                    ),
                    _DashboardButton(
                      icon: Icons.local_florist,
                      label: "Jardin",
                      onTap: () {},
                    ),
                    _DashboardButton(
                      icon: Icons.photo,
                      label: "Galerie",
                      onTap: () {},
                    ),
                    _DashboardButton(
                      icon: Icons.book,
                      label: "Journal",
                      onTap: () {},
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class _DashboardButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _DashboardButton({
    required this.icon,
    required this.label,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(30),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.85),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 32, color: Colors.green[800]),
            const SizedBox(height: 8),
            Text(label, style: const TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}