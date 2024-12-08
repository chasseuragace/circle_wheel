# circle_wheel

A powerful and flexible circular wheel widget for Flutter that enables you to create beautiful, interactive radial layouts with smooth 360-degree rotation.

[![pub package](https://img.shields.io/pub/v/circle_wheel.svg)](https://pub.dev/packages/circle_wheel)
[![likes](https://img.shields.io/pub/likes/circle_wheel?logo=dart)](https://pub.dev/packages/circle_wheel/score)
[![popularity](https://img.shields.io/pub/popularity/circle_wheel?logo=dart)](https://pub.dev/packages/circle_wheel/score)
[![style: flutter lints](https://img.shields.io/badge/style-flutter__lints-blue)](https://pub.dev/packages/flutter_lints)

## Features

**Rich Rotation Controls**
- Smooth 360-degree rotation with gesture support
- Customizable rotation resistance and animation curves
- Optional snap-to-position and bounce-back effects

**Smart Hotspot System**
- Define single or multiple hotspot positions
- Dynamic item scaling and styling at hotspots
- Customizable hotspot angles and ranges

**Flexible Styling**
- Support for any widget as items
- Dynamic scaling and animations
- Customizable colors, shadows, and effects
- Flexible layout options (full or partial circles)

**Performance Optimized**
- Efficient rendering system
- Optional visibility-based rendering
- Smooth animations and transitions

**Accessibility Ready**
- Semantic labels support
- Optional haptic feedback
- Configurable interaction modes

## Platform Support

| Platform | Support |
|----------|---------|
| Android  | ✅      |
| iOS      | ✅      |
| Web      | ✅      |
| Windows  | ✅      |
| macOS    | ✅      |
| Linux    | ✅      |

## Requirements

- Dart SDK: ^3.5.4
- Flutter: >=1.17.0
- Android: minSdkVersion 16
- iOS: iOS 11.0 or higher
- Web: All modern browsers (Chrome, Firefox, Safari, Edge)
- Desktop: Windows 10 or higher, macOS 10.14 or higher, Linux (GTK 3.x)

## Installation

Add circle_wheel to your pubspec.yaml:

```yaml
dependencies:
  circle_wheel: ^0.1.0
```

## Basic Usage

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

## Advanced Usage

### Interactive Menu

```dart
CircleWheel(
  radius: 150,
  itemCount: 6,
  snapToHotspot: true,
  hotspotScale: 1.2,
  onItemSelected: (index) {
    // Handle item selection
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

### Auto-Rotating Display

```dart
CircleWheel(
  radius: 180,
  itemCount: 12,
  autoRotate: true,
  autoRotateSpeed: 0.5,
  renderOnlyVisible: true,
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

## Customization

The widget supports extensive customization options:

### Animation Options
- `rotationDuration`: Duration of rotation animations
- `rotationCurve`: Animation curve for rotations
- `hotspotTransitionDuration`: Duration of hotspot transitions
- `autoRotate`: Enable automatic rotation
- `autoRotateSpeed`: Speed of automatic rotation

### Layout Options
- `radius`: Wheel radius
- `spacing`: Space between items
- `startAngle`: Starting angle of the wheel
- `endAngle`: Optional ending angle for partial wheels
- `innerRadius`: Optional inner radius for ring layouts

### Interaction Options
- `snapToHotspot`: Enable snapping to hotspots
- `rotationResistance`: Control rotation sensitivity
- `bounceBack`: Enable bounce-back effect
- `multipleHotspots`: Define multiple hotspot positions

### Event Callbacks
- `onItemSelected`: Called when an item is selected
- `onItemEnterHotspot`: Called when an item enters a hotspot
- `onItemExitHotspot`: Called when an item exits a hotspot
- `onRotationComplete`: Called when rotation animation completes

### Styling Options
- `itemScale`: Base scale factor for items
- `hotspotScale`: Scale factor for items in hotspots
- `itemAlignment`: Alignment of items
- `itemPadding`: Padding around items

### Performance Options
- `preloadItems`: Enable item preloading
- `cacheItems`: Enable item caching
- `renderOnlyVisible`: Only render visible items

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

```
MIT License

Copyright (c) 2024 Your Name

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
