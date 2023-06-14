import 'package:flutter/material.dart';

class QRScannerOverlay extends StatefulWidget {
  const QRScannerOverlay({super.key, required this.overlayColour});

  final Color overlayColour;

  @override
  State<QRScannerOverlay> createState() => _QRScannerOverlayState();
}

class _QRScannerOverlayState extends State<QRScannerOverlay>
    with TickerProviderStateMixin {
  late Animation<double> _animation;
  late AnimationController _controller;

  // 起始之间的线性插值器 从 0.05 到 0.95 百分比。
  final Tween<double> _rotationTween = Tween(begin: 0.05, end: 0.95);

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    );

    _animation = _rotationTween.animate(_controller)
      ..addListener(() => setState(() {}))
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _controller.repeat();
        } else if (status == AnimationStatus.dismissed) {
          _controller.forward();
        }
      });

    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 280.0
        : 320.0;
    return Stack(
      children: [
        ColorFiltered(
          colorFilter: ColorFilter.mode(
            widget.overlayColour,
            BlendMode.srcOut,
          ), // This one will create the magic
          child: Stack(
            children: [
              Container(
                decoration: const BoxDecoration(
                  color: Colors.black,
                  backgroundBlendMode: BlendMode.dstOut,
                ), // This one will handle background + difference out
              ),
              Align(
                alignment: Alignment.center,
                child: Container(
                  height: scanArea,
                  width: scanArea,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ],
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: CustomPaint(
            foregroundPainter: BorderPainter(
              lineMoveValue: _animation.value,
              areaWidth: scanArea,
              areaHeight: scanArea,
            ),
            // 撑起内容区域作用
            child: SizedBox(
              width: scanArea + 25,
              height: scanArea + 25,
            ),
          ),
        ),
      ],
    );
  }
}

// Creates the white borders
class BorderPainter extends CustomPainter {
  BorderPainter({
    required this.lineMoveValue,
    required this.areaWidth,
    required this.areaHeight,
  });

  /// 百分比值，0 ~ 1, 然后计算Y坐标
  final double lineMoveValue;
  final double areaWidth;
  final double areaHeight;

  @override
  void paint(Canvas canvas, Size size) {
    // 画线
    _painScanLine(size, canvas);
    // 画四角
    _paintBorderLine(canvas: canvas, size: size);
  }

  /// 绘制扫描运动线
  void _painScanLine(Size size, Canvas canvas) {
    final Size frameSize = Size(areaWidth, areaHeight);
    Offset diff = (size - frameSize) as Offset;
    double lineY = (diff.dy + frameSize.height) * lineMoveValue;

    // 10 为线条与方框之间的间距，绘制扫描线
    canvas.drawLine(
      Offset(diff.dx, lineY), // 开始点坐标: x,y
      Offset(areaWidth, lineY), // 结束点坐标: x,y
      Paint()
        ..strokeWidth = 2
        ..color = Colors.redAccent,
    );
  }

  /// 绘制四角边框
  void _paintBorderLine({required Canvas canvas, required Size size}) {
    const width = 3.0;
    const radius = 20.0;
    const tRadius = 3 * radius;
    final rect = Rect.fromLTWH(
      width,
      width,
      size.width - 2 * width,
      size.height - 2 * width,
    );
    final rrect = RRect.fromRectAndRadius(rect, const Radius.circular(radius));

    const clippingRect0 = Rect.fromLTWH(0, 0, tRadius, tRadius);
    final clippingRect1 =
        Rect.fromLTWH(size.width - tRadius, 0, tRadius, tRadius);
    final clippingRect2 =
        Rect.fromLTWH(0, size.height - tRadius, tRadius, tRadius);
    final clippingRect3 = Rect.fromLTWH(
        size.width - tRadius, size.height - tRadius, tRadius, tRadius);
    final path = Path()
      ..addRect(clippingRect0)
      ..addRect(clippingRect1)
      ..addRect(clippingRect2)
      ..addRect(clippingRect3);

    canvas.clipPath(path);
    canvas.drawRRect(
      rrect,
      Paint()
        ..color = Colors.white
        ..style = PaintingStyle.stroke
        ..strokeWidth = width,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
