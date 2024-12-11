import 'package:flutter/material.dart';
import 'package:circle_wheel/circle_wheel.dart';
import 'dart:math' as math;

class TodoListExample extends StatefulWidget {
  const TodoListExample({super.key});

  @override
  State<TodoListExample> createState() => _TodoListExampleState();
}

class _TodoListExampleState extends State<TodoListExample> {
  final List<bool> _checked = List<bool>.filled(40, false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Todo List')),
      body: Align(
        alignment: Alignment.center,
        child: Transform.translate(
          offset: Offset(-200, 0),
          child: CircleWheel(
            itemCount: 40,
            radius: 180,
            canRotate: true,
            renderOnlyVisible: true,
            visibilityStartAngle: 3 * math.pi / 2,
            visibilityEndAngle: math.pi / 2,
            hotspotAngle: 0,
            hotspotRange: math.pi / 40,
            itemScale: 1.0,
            hotspotScale: 1.5,
            hotspotTransitionDuration: const Duration(milliseconds: 200),
            itemBuilder: (index, isAtHotspot) {
              return AnimatedScale(
                duration: const Duration(milliseconds: 200),
                scale: isAtHotspot ? 1.5 : 1.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Checkbox(
                      value: _checked[index],
                      onChanged: (bool? value) {
                        setState(() {
                          _checked[index] = value ?? false;
                        });
                      },
                    ),
                    Text(
                      'Task ${index + 1}',
                      style: const TextStyle(color: Colors.black, fontSize: 12),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
