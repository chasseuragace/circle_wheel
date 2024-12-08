/// CircleWheel Widget Documentation
/// CircleWheel 위젯 문서
///
/// This widget creates a circular/radial layout that can display items in a wheel formation.
/// 이 위젯은 아이템들을 휠 형태로 표시할 수 있는 원형/방사형 레이아웃을 생성합니다.
///
/// Features (기능):
/// 1. 360-degree rotation support (360도 회전 지원)
/// 2. Multiple hotspot detection (다중 핫스팟 감지)
/// 3. Customizable animations (커스터마이징 가능한 애니메이션)
/// 4. Gesture-based interaction (제스처 기반 상호작용)
/// 5. Auto-rotation capability (자동 회전 기능)
///
/// Main Options (주요 옵션):
/// 1. Layout Options (레이아웃 옵션)
///    - radius: Wheel radius (휠 반지름)
///    - spacing: Space between items (아이템 간 간격)
///    - innerRadius: Optional inner radius for ring layout (링 레이아웃을 위한 내부 반지름)
///    - startAngle/endAngle: Control wheel's angular span (휠의 각도 범위 제어)
///
/// 2. Interaction Options (상호작용 옵션)
///    - canRotate: Enable/disable rotation (회전 활성화/비활성화)
///    - snapToHotspot: Snap items to hotspots (아이템을 핫스팟에 스냅)
///    - rotationResistance: Control rotation sensitivity (회전 감도 제어)
///    - bounceBack: Enable bounce effect (바운스 효과 활성화)
///
/// 3. Animation Options (애니메이션 옵션)
///    - rotationDuration: Duration of rotation animation (회전 애니메이션 지속 시간)
///    - rotationCurve: Animation curve type (애니메이션 곡선 유형)
///    - autoRotate: Enable automatic rotation (자동 회전 활성화)
///    - autoRotateSpeed: Speed of auto-rotation (자동 회전 속도)
///
/// 4. Hotspot Options (핫스팟 옵션)
///    - hotspotAngle: Angle for hotspot detection (핫스팟 감지 각도)
///    - hotspotRange: Active range around hotspot (핫스팟 주변 활성 범위)
///    - multipleHotspots: Additional hotspot angles (추가 핫스팟 각도)
///
/// 5. Styling Options (스타일링 옵션)
///    - itemScale: Base scale of items (아이템 기본 크기)
///    - hotspotScale: Scale of items in hotspot (핫스팟에 있는 아이템 크기)
///    - itemAlignment: Item alignment in container (컨테이너 내 아이템 정렬)
///    - itemPadding: Padding around items (아이템 주변 패딩)
///
/// 6. Performance Options (성능 옵션)
///    - preloadItems: Enable item preloading (아이템 미리 로드)
///    - cacheItems: Enable item caching (아이템 캐싱)
///    - renderOnlyVisible: Render only visible items (보이는 아이템만 렌더링)
///
/// Events & Callbacks (이벤트 & 콜백):
/// - onItemEnterHotspot: Called when item enters hotspot (아이템이 핫스팟에 진입할 때 호출)
/// - onItemExitHotspot: Called when item exits hotspot (아이템이 핫스팟에서 나갈 때 호출)
/// - onRotationComplete: Called after rotation ends (회전이 끝난 후 호출)
/// - onItemSelected: Called when item is selected (아이템이 선택됐을 때 호출)
///
/// Usage Example (사용 예시):
/// ```dart
/// CircleWheel(
///   itemBuilder: (index, isAtHotspot) => YourItemWidget(),
///   itemCount: 10,
///   radius: 150,
///   canRotate: true,
///   hotspotAngle: math.pi / 2,
///   autoRotate: false,
/// )
/// ```

library circle_wheel;

import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:flutter/services.dart';

enum RadialRotation {
  toTop,
  toCenter,
  toOutside,
  none,
}

/// A callback function that is called when an item enters or exits a hotspot
/// 아이템이 핫스팟에 들어가거나 나올 때 호출되는 콜백 함수
typedef HotspotCallback = void Function(int index);

/// A highly customizable circular wheel widget that supports 360-degree rotation,
/// multiple hotspots, and rich interaction options.
/// 360도 회전, 다중 핫스팟 및 다양한 상호작용 옵션을 지원하는 높은 수준의 커스터마이징이 가능한 원형 휠 위젯
class CircleWheel extends StatefulWidget {
  /// Builder function for creating wheel items
  /// 휠 아이템을 생성하기 위한 빌더 함수
  final Widget Function(int index, bool isAtHotspot) itemBuilder;

  /// Number of items to display in the wheel
  /// 휠에 표시할 아이템의 개수
  final int itemCount;

  /// Radius of the wheel
  /// 휠의 반지름
  final double radius;

  /// Rotation behavior of the items
  /// 아이템의 회전 동작
  final RadialRotation rotation;

  /// Whether the wheel can be rotated by gestures
  /// 제스처로 휠을 회전할 수 있는지 여부
  final bool canRotate;

  /// Angle at which hotspot detection occurs (in radians)
  /// Set to null to disable hotspot detection completely
  /// 핫스팟 감지가 발생하는 각도 (라디안)
  /// null로 설정하면 핫스팟 감지가 완전히 비활성화됨
  final double? hotspotAngle;

  /// Range around the hotspot angle where detection is active (in radians)
  /// Ignored if hotspotAngle is null
  /// 핫스팟 감지가 활성화되는 각도 범위 (라디안)
  /// hotspotAngle이 null이면 무시됨
  final double hotspotRange;

  // Animation options
  /// Duration of rotation animations
  /// 회전 애니메이션의 지속 시간
  final Duration rotationDuration;

  /// Curve to use for rotation animations
  /// 회전 애니메이션에 사용할 곡선
  final Curve rotationCurve;

  /// Duration of hotspot transition animations
  /// 핫스팟 전환 애니메이션의 지속 시간
  final Duration hotspotTransitionDuration;

  /// Whether the wheel should auto-rotate
  /// 휠이 자동으로 회전해야 하는지 여부
  final bool autoRotate;

  /// Speed of auto-rotation (when enabled)
  /// 자동 회전 속도 (활성화된 경우)
  final double autoRotateSpeed;

  // Layout options
  /// Spacing between items
  /// 아이템 간의 간격
  final double spacing;

  /// Starting angle of the wheel (in radians)
  /// 휠의 시작 각도 (라디안)
  final double startAngle;

  /// Ending angle of the wheel (in radians, optional)
  /// 휠의 종료 각도 (라디안, 선택사항)
  final double? endAngle;

  /// Inner radius for creating ring-like layouts
  /// 링 형태의 레이아웃을 만들기 위한 내부 반지름
  final double? innerRadius;

  // Interaction options
  /// Whether items should snap to hotspots
  /// 아이템이 핫스팟에 스냅되어야 하는지 여부
  final bool snapToHotspot;

  /// Resistance factor for rotation gestures
  /// 회전 제스처에 대한 저항 계수
  final double rotationResistance;

  /// Whether items should bounce back after rotation
  /// 회전 후 아이템이 튕겨져야 하는지 여부
  final bool bounceBack;

  /// List of additional hotspot angles (in radians)
  /// 추가 핫스팟 각도 목록 (라디안)
  final List<double>? multipleHotspots;

  // Event callbacks
  /// Called when an item enters a hotspot
  /// 아이템이 핫스팟에 들어갈 때 호출됨
  final HotspotCallback? onItemEnterHotspot;

  /// Called when an item exits a hotspot
  /// 아이템이 핫스팟에서 나올 때 호출됨
  final HotspotCallback? onItemExitHotspot;

  /// Called when rotation animation completes
  /// 회전 애니메이션이 완료될 때 호출됨
  final VoidCallback? onRotationComplete;

  /// Called when an item is selected
  /// 아이템이 선택될 때 호출됨
  final Function(int index)? onItemSelected;

  // Styling options
  /// Base scale factor for items
  /// 아이템의 기본 크기 비율
  final double itemScale;

  /// Scale factor for items in hotspots
  /// 핫스팟에 있는 아이템의 크기 비율
  final double hotspotScale;

  /// Alignment of items within their containers
  /// 컨테이너 내 아이템의 정렬
  final Alignment itemAlignment;

  /// Padding around items
  /// 아이템 주변의 패딩
  final EdgeInsets itemPadding;

  // Accessibility options
  /// Function to generate semantic labels for items
  /// 아이템의 시맨틱 레이블을 생성하는 함수
  final String Function(int index)? semanticsLabel;

  /// Whether rotation gestures are enabled
  /// 회전 제스처가 활성화되어 있는지 여부
  final bool rotationEnabled;

  /// Whether to provide haptic feedback
  /// 햅틱 피드백을 제공할지 여부
  final bool hapticFeedback;

  // Performance options
  /// Whether to preload items
  /// 아이템을 미리 로드할지 여부
  final bool preloadItems;

  /// Whether to cache rendered items
  /// 렌더링된 아이템을 캐시할지 여부
  final bool cacheItems;

  /// Whether to only render visible items
  /// 보이는 아이템만 렌더링할지 여부
  final bool renderOnlyVisible;

  /// The angle at which items start becoming invisible (in radians)
  /// 아이템이 사라지기 시작하는 각도 (라디안)
  final double? visibilityStartAngle;

  /// The angle at which items become visible again (in radians)
  /// 아이템이 다시 나타나는 각도 (라디안)
  final double? visibilityEndAngle;

  /// Creates a CircleWheel widget with customizable options for rotation,
  /// interaction, styling, and performance.
  /// 회전, 상호작용, 스타일링 및 성능을 위한 커스터마이징 옵션으로 CircleWheel 위젯을 생성합니다.
  const CircleWheel({
    super.key,
    required this.itemBuilder,
    this.itemCount = 80,
    this.radius = 180,
    this.rotation = RadialRotation.toTop,
    this.canRotate = false,
    this.hotspotAngle,
    this.hotspotRange = math.pi / 12,

    // Animation options
    this.rotationDuration = const Duration(milliseconds: 300),
    this.rotationCurve = Curves.easeInOut,
    this.hotspotTransitionDuration = const Duration(milliseconds: 200),
    this.autoRotate = false,
    this.autoRotateSpeed = 1.0,

    // Layout options
    this.spacing = 0,
    this.startAngle = 0,
    this.endAngle,
    this.innerRadius,

    // Interaction options
    this.snapToHotspot = false,
    this.rotationResistance = 1.0,
    this.bounceBack = false,
    this.multipleHotspots,

    // Event callbacks
    this.onItemEnterHotspot,
    this.onItemExitHotspot,
    this.onRotationComplete,
    this.onItemSelected,

    // Styling options
    this.itemScale = 1.0,
    this.hotspotScale = 1.2,
    this.itemAlignment = Alignment.center,
    this.itemPadding = EdgeInsets.zero,

    // Accessibility options
    this.semanticsLabel,
    this.rotationEnabled = true,
    this.hapticFeedback = true,

    // Performance options
    this.preloadItems = false,
    this.cacheItems = true,
    this.renderOnlyVisible = true,
    this.visibilityStartAngle,
    this.visibilityEndAngle,
  });

  @override
  State<CircleWheel> createState() => _CircleWheelState();
}

class _CircleWheelState extends State<CircleWheel>
    with SingleTickerProviderStateMixin {
  /// Current rotation value of the wheel
  /// 휠의 현재 회전 값
  double _rotationValue = 0.0;

  /// Starting position of rotation gesture
  /// 회전 제스처의 시작 위치
  Offset? _startPosition;

  /// Controller for rotation animations
  /// 회전 애니메이션을 위한 컨트롤러
  late AnimationController _rotationController;

  /// Animation for smooth rotation transitions
  /// 부드러운 회전 전환을 위한 애니메이션
  late Animation<double> _rotationAnimation;

  /// Map to track hotspot states of items
  /// 아이템의 핫스팟 상태를 추적하기 위한 맵
  Map<int, bool> _hotspotStates = {};

  @override
  void initState() {
    super.initState();
    _initializeAnimationController();
    if (widget.autoRotate) {
      _startAutoRotation();
    }
  }

  /// Initializes the animation controller and sets up listeners
  /// 애니메이션 컨트롤러를 초기화하고 리스너를 설정합니다.
  void _initializeAnimationController() {
    _rotationController = AnimationController(
      vsync: this,
      duration: widget.rotationDuration,
    );

    _rotationAnimation = Tween<double>(
      begin: 0,
      end: 0,
    ).animate(CurvedAnimation(
      parent: _rotationController,
      curve: widget.rotationCurve,
    ));

    _rotationAnimation.addListener(() {
      setState(() {
        _rotationValue = _rotationAnimation.value;
      });
    });

    _rotationAnimation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        widget.onRotationComplete?.call();
      }
    });
  }

  /// Starts auto-rotation if enabled
  /// 자동 회전을 시작합니다 (활성화된 경우).
  void _startAutoRotation() {
    Future.doWhile(() async {
      await Future.delayed(const Duration(milliseconds: 16)); // ~60fps
      if (!mounted || !widget.autoRotate) return false;

      setState(() {
        _rotationValue += widget.autoRotateSpeed * 0.01;
      });
      return true;
    });
  }

  /// Checks if an item is in a hotspot
  /// 아이템이 핫스팟에 있는지 확인합니다.
  bool _isInHotspot(double angle) {
    if (widget.hotspotAngle == null)
      return false; // No hotspot if angle is null

    final normalizedAngle = (angle % (2 * math.pi));
    final normalizedHotspotAngle = (widget.hotspotAngle! % (2 * math.pi));

    final difference = (normalizedAngle - normalizedHotspotAngle).abs();
    final wrappedDifference = math.min(
      difference,
      2 * math.pi - difference,
    );

    return wrappedDifference <= widget.hotspotRange;
  }

  /// Handles hotspot state changes and triggers callbacks
  /// 핫스팟 상태 변경을 처리하고 콜백을 호출합니다.
  void _checkHotspotStateChanges(int index, bool currentState) {
    bool previousState = _hotspotStates[index] ?? false;
    if (currentState != previousState) {
      _hotspotStates[index] = currentState;
      if (currentState) {
        widget.onItemEnterHotspot?.call(index);
        if (widget.hapticFeedback) {
          HapticFeedback.lightImpact();
        }
      } else {
        widget.onItemExitHotspot?.call(index);
      }
    }
  }

  /// Handles pan update gestures for rotation
  /// 회전을 위한 패닝 제스처를 처리합니다.
  void _onPanUpdate(DragUpdateDetails details) {
    if (!widget.canRotate || !widget.rotationEnabled) return;
    if (_startPosition == null) return;

    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final center = renderBox.size.center(Offset.zero);
    final touchPoint = details.localPosition;

    final previousAngle = math.atan2(
      _startPosition!.dy - center.dy,
      _startPosition!.dx - center.dx,
    );
    final currentAngle = math.atan2(
      touchPoint.dy - center.dy,
      touchPoint.dx - center.dx,
    );

    setState(() {
      _rotationValue +=
          (currentAngle - previousAngle) / widget.rotationResistance;
      _startPosition = touchPoint;
    });

    if (widget.snapToHotspot) {
      _snapToNearestHotspot();
    }
  }

  /// Snaps the wheel to the nearest hotspot
  /// 휠을 가장 가까운 핫스팟으로 스냅합니다.
  void _snapToNearestHotspot() {
    double nearestHotspot = widget.hotspotAngle ?? 0;
    if (widget.multipleHotspots != null &&
        widget.multipleHotspots!.isNotEmpty) {
      nearestHotspot = widget.multipleHotspots!.reduce((a, b) {
        double diffA = (a - _rotationValue).abs();
        double diffB = (b - _rotationValue).abs();
        return diffA < diffB ? a : b;
      });
    }

    _rotationAnimation = Tween<double>(
      begin: _rotationValue,
      end: nearestHotspot,
    ).animate(CurvedAnimation(
      parent: _rotationController,
      curve: widget.rotationCurve,
    ));

    _rotationController.forward(from: 0);
  }

  void _onPanStart(DragStartDetails details) {
    if (!widget.canRotate || !widget.rotationEnabled) return;
    _startPosition = details.localPosition;
  }

  void _onPanEnd(DragEndDetails details) {
    if (!widget.canRotate || !widget.rotationEnabled) return;
    _startPosition = null;

    if (widget.bounceBack) {
      _snapToNearestHotspot();
    }
  }

  @override
  void dispose() {
    _rotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: (widget.radius * 2) + 100,
      height: (widget.radius * 2) + 100,
      color: Colors.transparent,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onPanStart: _onPanStart,
        onPanUpdate: _onPanUpdate,
        onPanEnd: _onPanEnd,
        child: Transform.rotate(
          angle: _rotationValue,
          child: Stack(
            alignment: Alignment.center,
            children: List.generate(widget.itemCount, (index) {
              if (widget.renderOnlyVisible) {
                final angle =
                    (index * (360 / widget.itemCount)) * (math.pi / 180);
                final isVisible = _isItemVisible(angle);
                if (!isVisible) return const SizedBox.shrink();
              }

              return _buildItem(index);
            }),
          ),
        ),
      ),
    );
  }

  /// Checks if an item is currently visible in the viewport
  /// 아이템이 현재 뷰포트에 표시되는지 확인합니다.
  bool _isItemVisible(double angle) {
    // 현재 회전값을 고려한 아이템의 실제 각도 계산
    double normalizedAngle = (angle + _rotationValue) % (2 * math.pi);
    if (normalizedAngle < 0) normalizedAngle += 2 * math.pi;

    // 화면 크기 가져오기
    final RenderBox? renderBox = context.findRenderObject() as RenderBox?;
    if (renderBox == null) return true;

    // 부모 위젯(Scaffold)의 크기 가져오기
    final RenderBox? parentBox = context
        .findRootAncestorStateOfType<ScaffoldState>()
        ?.context
        .findRenderObject() as RenderBox?;
    if (parentBox == null) return true;

    // CircleWheel의 중심점 위치를 전역 좌표로 변환
    final Offset centerGlobal = renderBox.localToGlobal(Offset.zero);

    // 아이템의 상대 위치 계산 (중심점만 고려)
    final double itemX = widget.radius * math.cos(normalizedAngle);
    final double itemY = widget.radius * math.sin(normalizedAngle);

    // 아이템의 중심점 위치 계산
    final double globalX = centerGlobal.dx + itemX;
    final double globalY = centerGlobal.dy + itemY;

    if (widget.renderOnlyVisible &&
        widget.visibilityStartAngle != null &&
        widget.visibilityEndAngle != null) {
      final startAngle = widget.visibilityStartAngle! % (2 * math.pi);
      final endAngle = widget.visibilityEndAngle! % (2 * math.pi);

      // 시작 각도가 끝 각도보다 작은 경우 (예: 0 -> π)
      if (startAngle <= endAngle) {
        final isBetweenAngles =
            normalizedAngle >= startAngle && normalizedAngle <= endAngle;
        return isBetweenAngles;
      }
      // 시작 각도가 끝 각도보다 큰 경우 (예: π -> 0)
      else {
        final isBetweenAngles =
            normalizedAngle >= startAngle || normalizedAngle <= endAngle;
        return isBetweenAngles;
      }
    }

    return false;
  }

  /// Builds an individual item in the wheel
  /// 휠의 개별 아이템을 빌드합니다.
  Widget _buildItem(int index) {
    final angle = widget.startAngle +
        (index *
            ((widget.endAngle ?? (2 * math.pi)) - widget.startAngle) /
            widget.itemCount);

    final isAtHotspot = _isInHotspot(angle);
    _checkHotspotStateChanges(index, isAtHotspot);

    double rotationAngle;
    switch (widget.rotation) {
      case RadialRotation.toTop:
        rotationAngle = angle;
        break;
      case RadialRotation.toCenter:
        rotationAngle = angle + math.pi;
        break;
      case RadialRotation.toOutside:
        rotationAngle = angle + math.pi / 2;
        break;
      case RadialRotation.none:
        rotationAngle = 0;
        break;
    }

    final scale = isAtHotspot ? widget.hotspotScale : widget.itemScale;

    return Transform(
      transform: Matrix4.identity()
        ..translate(
          (widget.innerRadius ?? widget.radius) * math.cos(angle),
          (widget.innerRadius ?? widget.radius) * math.sin(angle),
        ),
      child: Transform.rotate(
        angle: rotationAngle,
        alignment: Alignment.center,
        child: Transform.scale(
          scale: scale,
          child: Padding(
            padding: widget.itemPadding,
            child: GestureDetector(
              onTap: () => widget.onItemSelected?.call(index),
              child: Semantics(
                label: widget.semanticsLabel?.call(index),
                child: AnimatedContainer(
                  duration: widget.hotspotTransitionDuration,
                  alignment: widget.itemAlignment,
                  child: widget.itemBuilder(index, isAtHotspot),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
