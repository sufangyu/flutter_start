import 'package:flutter/material.dart';

class ScanAreaWidget extends StatefulWidget {
  const ScanAreaWidget({super.key, this.scanArea});

  final Size? scanArea;

  @override
  State<ScanAreaWidget> createState() => _ScanAreaWidgetState();
}

class _ScanAreaWidgetState extends State<ScanAreaWidget>
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
      duration: const Duration(seconds: 8),
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
    Size size = widget.scanArea ?? MediaQuery.of(context).size;
    return Stack(
      children: [
        Align(
          alignment: Alignment.center,
          child: CustomPaint(
            foregroundPainter: _ScanFramePainter(
              lineMoveValue: _animation.value,
              scanSize: size,
            ),
            // painter: _ScanFramePainter(
            //   lineMoveValue: _animation.value,
            //   scanSize: widget.scanArea ?? MediaQuery.of(context).size,
            // ),
            child: Container(
              color: Colors.black.withOpacity(0),
              width: size.width,
              height: size.height,
            ),
          ),
        ),
      ],
    );
  }
}

class _ScanFramePainter extends CustomPainter {
  _ScanFramePainter({required this.lineMoveValue, required this.scanSize});

  final double lineMoveValue; // 百分比值，0 ~ 1，然后计算Y坐标
  final Size scanSize;

  /// 绘图的主要实现
  @override
  void paint(Canvas canvas, Size size) {
    // 根据左上角的坐标和扫描框的大小可得知扫描框矩形
    const double space = 10.0;
    Rect rect = Rect.fromLTWH(
      space,
      space,
      scanSize.width - space * 2,
      scanSize.height - space * 2,
    );

    /// 绘制扫描区域 -------------------------------------
    canvas.drawRect(
      rect,
      Paint()
        ..color = Colors.white.withOpacity(0)
        ..style = PaintingStyle.fill,
    );

    /// 绘制 扫描线条效果 -------------------------------------
    var lineY = scanSize.height * lineMoveValue;
    // 为线条与方框之间的间距，绘制扫描线
    canvas.drawLine(
      Offset(space, lineY),
      Offset(scanSize.width - space, lineY),
      Paint()
        ..strokeWidth = 1
        ..color = Colors.redAccent,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // 返回true 则会重新绘制，执行 paint函数，返回false 则不会重新绘制
    return true;
  }
}
