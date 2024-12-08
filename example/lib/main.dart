import 'package:flutter/material.dart';
import 'package:circle_wheel/circle_wheel.dart';
import 'dart:math' as math;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CircleWheel Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // Example items for the wheel
  final List<String> items = List.generate(12, (index) => 'Item ${index + 1}');
  bool _autoRotate = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('CircleWheel Demo'),
        actions: [
          IconButton(
            icon: Icon(_autoRotate ? Icons.pause : Icons.play_arrow),
            onPressed: () {
              setState(() {
                _autoRotate = !_autoRotate;
              });
            },
            tooltip: _autoRotate ? 'Stop Auto-rotation' : 'Start Auto-rotation',
          ),
        ],
      ),
      body: Center(
        child: CircleWheel(
          // Basic configuration
          itemCount: items.length,
          radius: 150,
          canRotate: true,

          // Angle configuration
          startAngle: 0,
          endAngle: 2 * math.pi,

          // Visibility configuration
          renderOnlyVisible: true,
          visibilityStartAngle: 0,
          visibilityEndAngle: math.pi * 1.5,

          // Hotspot configuration
          hotspotAngle: math.pi / 2, // Top position
          hotspotRange: math.pi / 12,

          // Animation configuration
          autoRotate: _autoRotate,
          autoRotateSpeed: 1.0,
          rotationDuration: const Duration(milliseconds: 300),

          // Interaction configuration
          snapToHotspot: false, // 핫스팟으로 자동 정렬 비활성화
          bounceBack: false, // 원래 위치로 돌아가기 비활성화
          rotationResistance: 1.0, // 회전 저항값 설정

          // Styling configuration
          itemScale: 1.0,
          hotspotScale: 1.2,

          // Performance options
          preloadItems: true, // 아이템 미리 로드
          cacheItems: true, // 아이템 캐싱 활성화

          // Item builder
          itemBuilder: (index, isAtHotspot) {
            return Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: isAtHotspot
                    ? Colors.deepPurple
                    : Colors.deepPurple.shade200,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  if (isAtHotspot)
                    const BoxShadow(
                      color: Colors.black26,
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                ],
              ),
              child: Center(
                child: Text(
                  items[index],
                  style: TextStyle(
                    color: isAtHotspot ? Colors.white : Colors.white70,
                    fontWeight:
                        isAtHotspot ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ),
            );
          },

          // Callbacks
          onItemEnterHotspot: (index) {
            debugPrint('Item $index entered hotspot');
          },
          onItemExitHotspot: (index) {
            debugPrint('Item $index exited hotspot');
          },
          onItemSelected: (index) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Selected ${items[index]}')),
            );
          },
        ),
      ),
    );
  }
}
