# circle_wheel

A powerful and flexible circular wheel widget for Flutter that enables you to create beautiful, interactive radial layouts with smooth 360-degree rotation.

Flutter에서 아름답고 상호작용이 가능한 방사형 레이아웃을 부드러운 360도 회전으로 구현할 수 있는 유연한 원형 휠 위젯입니다.

[![pub package](https://img.shields.io/pub/v/circle_wheel.svg)](https://pub.dev/packages/circle_wheel)
[![likes](https://img.shields.io/pub/likes/circle_wheel?logo=dart)](https://pub.dev/packages/circle_wheel/score)
[![popularity](https://img.shields.io/pub/popularity/circle_wheel?logo=dart)](https://pub.dev/packages/circle_wheel/score)
[![style: flutter lints](https://img.shields.io/badge/style-flutter__lints-blue)](https://pub.dev/packages/flutter_lints)

## Examples / 예제

![Circle Wheel Example 1](https://raw.githubusercontent.com/swuhalee/circle_wheel/main/images/example1.png)|![Circle Wheel Example 2](https://raw.githubusercontent.com/swuhalee/circle_wheel/main/images/example2.png)|![Circle Wheel Example 3](https://raw.githubusercontent.com/swuhalee/circle_wheel/main/images/example3.png)
|---|---|---|


## Features / 특징

**Rich Rotation Controls / 풍부한 회전 제어**
- Smooth 360-degree rotation with gesture support / 제스처를 지원하는 부드러운 360도 회전
- Customizable rotation resistance and animation curves / 회전 저항과 애니메이션 곡선 커스터마이징
- Optional bounce-back effects / 선택적 바운스백 효과

**Smart Hotspot System / 스마트 핫스팟 시스템**
- Define single or multiple hotspot positions / 단일 및 다중 핫스팟 위치 정의
- Dynamic item scaling at hotspots / 핫스팟에서의 동적 아이템 크기 조절
- Customizable hotspot angles and ranges / 커스터마이징 가능한 핫스팟 각도와 범위

**Flexible Styling / 유연한 스타일링**
- Support for any widget as items / 모든 위젯을 아이템으로 지원
- Dynamic scaling and animations / 동적 크기 조절과 애니메이션
- Flexible layout options (full or partial circles) / 유연한 레이아웃 옵션 (부채꼴도 가능함)

**Performance Optimized / 성능 최적화**
- Optional visibility-based rendering / 선택적 가시성 기반 렌더링
- Smooth animations and transitions / 부드러운 애니메이션과 전환

**Accessibility Ready / 접근성 지원**
- Semantic labels support / 시맨틱 레이블 지원
- Optional haptic feedback / 선택적 햅틱 피드백
- Configurable interaction modes / 설정 가능한 상호작용 모드

## Platform Support / 플랫폼 지원

| Platform / 플랫폼 | Support / 지원 |
|----------|---------|
| Android  | ✅      |
| iOS      | ✅      |
| Web      | ✅      |
| Windows  | ✅      |
| macOS    | ✅      |
| Linux    | ✅      |

## Requirements / 요구사항

- Dart SDK: ^3.5.4
- Flutter: >=1.17.0
- Android: minSdkVersion 16
- iOS: iOS 11.0 or higher
- Web: All modern browsers
- Desktop: Windows 10+, macOS 10.14+, Linux (GTK 3.x)

## Installation / 설치

Add circle_wheel to your pubspec.yaml:
pubspec.yaml에 circle_wheel을 추가하세요:

```yaml
dependencies:
  circle_wheel: 0.0.1+2
```

## Basic Usage / 기본 사용법

```dart
import 'package:circle_wheel/circle_wheel.dart';

CircleWheel(
  radius: 150,
  itemCount: 8,
  itemBuilder: (index, isAtHotspot) {
    return Icon(
      Icons.star,
      size: isAtHotspot ? 32 : 24,
      color: isAtHotspot ? Colors.amber : Colors.grey,
    );
  },
)
```

## Advanced Usage / 고급 사용법

### Interactive Menu / 대화형 메뉴

```dart
CircleWheel(
  radius: 150,
  itemCount: 6,
  snapToHotspot: true,
  hotspotScale: 1.2,
  onItemSelected: (index) {
    // Handle item selection
    // 아이템 선택 처리
  },
  itemBuilder: (index, isAtHotspot) {
    return MenuOption(
      icon: menuIcons[index],
      label: menuLabels[index],
      isSelected: isAtHotspot,
    );
  },
)
```

### Auto-Rotating Display / 자동 회전 디스플레이

```dart
CircleWheel(
  radius: 180,
  itemCount: 12,
  autoRotate: true,
  autoRotateSpeed: 0.5,
  itemBuilder: (index, isAtHotspot) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      width: isAtHotspot ? 100 : 80,
      height: isAtHotspot ? 100 : 80,
      child: YourCustomWidget(),
    );
  },
)
```

## Customization / 커스터마이징

### Core Options / 주요 옵션

#### Animation Options / 애니메이션 옵션
- `rotationDuration`: Duration of rotation animations / 회전 애니메이션 지속 시간
- `rotationCurve`: Animation curve for rotations / 회전 애니메이션 곡선
- `hotspotTransitionDuration`: Duration of hotspot transitions / 핫스팟 전환 지속 시간
- `autoRotate`: Enable automatic rotation / 자동 회전 활성화
- `autoRotateSpeed`: Speed of automatic rotation / 자동 회전 속도

#### Layout Options / 레이아웃 옵션
- `radius`: Wheel radius / 휠 반지름
- `startAngle`: Starting angle of the wheel / 휠 시작 각도
- `endAngle`: Optional ending angle for partial wheels / 부분 휠을 위한 선택적 종료 각도
- `innerRadius`: Optional inner radius for ring layouts / 링 레이아웃을 위한 선택적 내부 반지름

#### Interaction Options / 상호작용 옵션
- `snapToHotspot`: Enable snapping to hotspots / 핫스팟 스냅 활성화
- `rotationResistance`: Control rotation sensitivity / 회전 감도 제어
- `bounceBack`: Enable bounce-back effect / 바운스백 효과 활성화
- `multipleHotspots`: Define multiple hotspot positions / 다중 핫스팟 위치 정의

## Contributing / 기여하기

Contributions are welcome! Please feel free to submit a Pull Request.

열심히 만들었습니다만... 안되는 부분이 있거나 추가하고 싶은 기능이 있다면 pr 또는 이슈를 올려주세요! 코드 리뷰도 환영합니다... (초보예요)
