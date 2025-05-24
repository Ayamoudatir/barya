import 'package:flutter/material.dart';
import 'dart:math';

class JardinPage extends StatefulWidget {
  const JardinPage({super.key});

  @override
  State<JardinPage> createState() => _JardinPageState();
}

class _PlacedItem {
  final String assetPath;
  Offset position;
  double scale;
  double rotation;
  bool selected;

  _PlacedItem({
    required this.assetPath,
    required this.position,
    this.scale = 1.0,
    this.rotation = 0.0,
    this.selected = false,
  });
}

class _JardinPageState extends State<JardinPage> {
  final List<String> assets = [
    'assets/garden/flower.png',
    'assets/garden/cloud.png',
    'assets/garden/storm.png',
    'assets/garden/vent.png',
  ];

  final List<_PlacedItem> placedItems = [];
  String? selectedAsset;
  final double terrainSize = 350;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mon Jardin Émotionnel 3D"),
        backgroundColor: Colors.green[700],
        centerTitle: true,
      ),
      body: Column(
        children: [
          // 🌼 Barre d’éléments
          SizedBox(
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: assets.length,
              itemBuilder: (context, index) {
                final asset = assets[index];
                return GestureDetector(
                  onTap: () {
                    setState(() => selectedAsset = asset);
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: selectedAsset == asset ? Colors.green[200] : Colors.green[50],
                      border: Border.all(color: Colors.green),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Image.asset(asset, width: 60, height: 60),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 10),

          // 🌱 Terrain interactif
          Expanded(
            child: Center(
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTapUp: (details) {
                  if (selectedAsset != null) {
                    final box = context.findRenderObject() as RenderBox;
                    final localPos = box.globalToLocal(details.globalPosition);

                    if (_isInsideTerrain(localPos)) {
                      setState(() {
                        for (var item in placedItems) {
                          item.selected = false;
                        }
                        placedItems.add(
                          _PlacedItem(
                            assetPath: selectedAsset!,
                            position: localPos,
                            scale: 1.5,
                            selected: true,
                          ),
                        );
                        selectedAsset = null;
                      });
                    }
                  }
                },
                child: Stack(
                  children: [
                    Center(
                      child: Container(
                        width: terrainSize,
                        height: terrainSize,
                        color: Colors.transparent,
                        child: Image.asset('assets/garden/terrain.png'),
                      ),
                    ),
                    ...placedItems.map((item) {
                      return Positioned(
                        left: item.position.dx - 35,
                        top: item.position.dy - 35,
                        child: GestureDetector(
                          onDoubleTap: () {
                            setState(() {
                              placedItems.remove(item);
                            });
                          },
                          onScaleUpdate: (details) {
                            setState(() {
                              item.scale *= details.scale;
                              item.rotation += details.rotation;
                              item.position += details.focalPointDelta;

                              item.position = Offset(
                                item.position.dx.clamp(0.0, terrainSize),
                                item.position.dy.clamp(0.0, terrainSize),
                              );
                            });
                          },
                          onTap: () {
                            setState(() {
                              for (var i in placedItems) {
                                i.selected = false;
                              }
                              item.selected = true;
                            });
                          },
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if (item.selected)
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.remove_circle_outline),
                                      iconSize: 20,
                                      onPressed: () {
                                        setState(() {
                                          item.scale = max(0.2, item.scale - 0.1);
                                        });
                                      },
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.add_circle_outline),
                                      iconSize: 20,
                                      onPressed: () {
                                        setState(() {
                                          item.scale += 0.1;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              Transform(
                                alignment: Alignment.center,
                                transform: Matrix4.identity()
                                  ..rotateZ(item.rotation)
                                  ..scale(item.scale),
                                child: Image.asset(
                                  item.assetPath,
                                  width: 70,
                                  height: 70,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  bool _isInsideTerrain(Offset pos) {
    return pos.dx >= 0 && pos.dy >= 0 && pos.dx <= terrainSize && pos.dy <= terrainSize;
  }
}