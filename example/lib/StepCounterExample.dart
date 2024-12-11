import 'package:flutter/material.dart';
import 'package:circle_wheel/circle_wheel.dart';
import 'dart:math' as math;

class StepCounterExample extends StatefulWidget {
  const StepCounterExample({super.key});

  @override
  State<StepCounterExample> createState() => _StepCounterExampleState();
}

class _StepCounterExampleState extends State<StepCounterExample> {
  final GlobalKey<CircleWheelState> _circleWheelKey =
      GlobalKey<CircleWheelState>();
  int currentStep = 0;
  final List<String> benchPressSteps = [
    '바벨을 랙에서 내리고 준비 자세',
    '어깨너비보다 약간 넓게 그립',
    '바벨을 가슴 위로 들어올림',
    '숨을 들이마시며 바벨을 내림',
    '가슴에 바벨이 닿을 때까지',
    '숨을 내쉬며 바벨을 밀어올림',
    '시작 자세로 돌아옴',
    '세트 완료, 바벨을 랙에 거치'
  ];

  final List<String> stepDescriptions = [
    '안전한 자세로 벤치에 누워 바벨을 랙에서 내립니다.',
    '손바닥이 앞을 향하게 하고 어깨너비보다 약간 넓게 그립합니다.',
    '팔꿈치를 고정하고 바벨을 가슴 위로 들어올립니다.',
    '천천히 통제된 동작으로 바벨을 내립니다.',
    '바벨이 가슴에 살짝 닿을 때까지 내립니다.',
    '가슴 근육에 힘을 주어 바벨을 밀어올립니다.',
    '팔이 완전히 펴질 때까지 바벨을 밀어올립니다.',
    '마지막 반복을 완료하고 바벨을 안전하게 랙에 거치합니다.'
  ];

  void _handleItemEnterHotspot(int index) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        currentStep = index;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('벤치프레스 가이드')),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: CircleWheel(
                key: _circleWheelKey,
                itemCount: benchPressSteps.length,
                radius: 150,
                canRotate: true,
                startAngle: math.pi, // 6시 방향에서 시작
                hotspotAngle: math.pi, // 6시 방향이 핫스팟
                hotspotRange: math.pi / 16,
                rotation: RadialRotation.toCenter, // 아이템이 위로 향하도록 수정
                onItemEnterHotspot: _handleItemEnterHotspot,
                itemBuilder: (index, isAtHotspot) {
                  return Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: isAtHotspot ? Colors.blue : Colors.blueAccent,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: index == currentStep
                            ? Colors.white
                            : Colors.transparent,
                        width: 2,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        '${index + 1}',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: isAtHotspot ? 24 : 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Container(
            height: 200,
            padding: const EdgeInsets.all(16),
            color: Colors.grey[200],
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  '스텝 ${currentStep + 1}: ${benchPressSteps[currentStep]}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  stepDescriptions[currentStep],
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      if (currentStep < benchPressSteps.length - 1) {
                        currentStep++;
                      } else {
                        currentStep = 0; // 마지막 스텝에서 처음으로 돌아감
                      }
                    });
                    // 현재 스텝을 핫스팟 위치로 이동
                    _circleWheelKey.currentState?.setRotation(currentStep);
                  },
                  child: Text(
                    currentStep < benchPressSteps.length - 1
                        ? '다음 스텝으로'
                        : '처음으로 돌아가기',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
