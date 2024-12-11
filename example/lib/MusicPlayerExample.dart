import 'package:flutter/material.dart';
import 'package:circle_wheel/circle_wheel.dart';
import 'dart:math' as math;

class MusicPlayerExample extends StatefulWidget {
  const MusicPlayerExample({super.key});

  @override
  State<MusicPlayerExample> createState() => _MusicPlayerExampleState();
}

class _MusicPlayerExampleState extends State<MusicPlayerExample> {
  int _currentSongIndex = 0;
  final List<String> _songTitles = [
    'Song A',
    'Song B',
    'Song C',
    'Song D',
    'Song E',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Music Player')),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: CircleWheel(
                itemCount: _songTitles.length,
                radius: 150,
                canRotate: true,
                autoRotate: true,
                autoRotateSpeed: 0.3,
                itemBuilder: (index, isAtHotspot) {
                  return Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          Colors.black,
                          Colors.grey.shade800,
                          Colors.grey.shade600,
                        ],
                        stops: const [0.3, 0.7, 1.0],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.5),
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        _songTitles[index],
                        style:
                            const TextStyle(color: Colors.white, fontSize: 14),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                },
                onItemSelected: (index) {
                  setState(() {
                    _currentSongIndex = index;
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Playing: ${_songTitles[index]}')),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Now Playing: ${_songTitles[_currentSongIndex]}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.play_arrow),
                  onPressed: () {
                    // Play action
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.stop),
                  onPressed: () {
                    // Stop action
                  },
                ),
              ],
            ),
            const SizedBox(height: 10),
            Slider(
              value: 0.5,
              onChanged: (value) {
                // Music bar action
              },
            ),
          ],
        ),
      ),
    );
  }
}
