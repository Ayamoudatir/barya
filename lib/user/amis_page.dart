import 'package:flutter/material.dart';

class AmisPage extends StatelessWidget {
  final List<Map<String, dynamic>> moodPosts = [
    {
      'name': 'Lina',
      'emoji': '😊',
      'message': "Je me sens pleine d’énergie aujourd'hui !",
      'color': Colors.yellow[100],
    },
    {
      'name': 'Yassir',
      'emoji': '😢',
      'message': "J’ai besoin de parler un peu…",
      'color': Colors.blue[100],
    },
    {
      'name': 'Aya',
      'emoji': '🔥',
      'message': "Motivée à fond pour coder !",
      'color': Colors.red[100],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      appBar: AppBar(
        title: const Text("Mur d'humeurs"),
        backgroundColor: Colors.green[700],
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: moodPosts.length,
        padding: const EdgeInsets.all(16),
        itemBuilder: (context, index) {
          final post = moodPosts[index];
          return Card(
            color: post['color'],
            margin: const EdgeInsets.only(bottom: 16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: ListTile(
              leading: CircleAvatar(child: Text(post['emoji'], style: const TextStyle(fontSize: 24))),
              title: Text(post['name'], style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(post['message']),
              trailing: IconButton(
                icon: const Icon(Icons.favorite_border),
                onPressed: () {},
              ),
            ),
          );
        },
      ),
    );
  }
}