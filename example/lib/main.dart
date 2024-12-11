import 'package:example/MusicPlayerExample.dart';
import 'package:example/StepCounterExample.dart';
import 'package:example/TodoListExample.dart';
import 'package:flutter/material.dart';

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

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CircleWheel Examples'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text('Music Player'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const MusicPlayerExample()),
              );
            },
          ),
          ListTile(
            title: const Text('Scheduler'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const TodoListExample()),
              );
            },
          ),
          ListTile(
            title: const Text('Step Counter'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const StepCounterExample()),
              );
            },
          ),
        ],
      ),
    );
  }
}
