// arc_progress_indicator.dart
import 'package:flutter/material.dart';
import 'dart:math' as math;

class ArcProgressIndicator extends StatelessWidget {
  final double progress;
  final double strokeWidth;
  final Color backgroundColor;
  final Color progressColor;
  final double width;
  final double height;
  final Widget child;


  const ArcProgressIndicator({
    Key? key,
    required this.progress,
    this.strokeWidth = 10.0,
    this.backgroundColor = const Color(0xFFEEEEEE),
    this.progressColor = Colors.blue,
    this.width = 200.0,
    this.height = 200.0,
    required this.child
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: CustomPaint(
        painter: _ArcPainter(
          progress: progress,
          strokeWidth: strokeWidth,
          backgroundColor: backgroundColor,
          progressColor: progressColor,
        ),
        child: Container(
          width: width,
          height: height,
          child: Center(child:child)
        )
      ),
    );
  }
}

class _ArcPainter extends CustomPainter {
  final double progress;
  final double strokeWidth;
  final Color backgroundColor;
  final Color progressColor;

  _ArcPainter({
    required this.progress,
    required this.strokeWidth,
    required this.backgroundColor,
    required this.progressColor,
  });

  // Utility function to convert degrees to radians
  double _radians(double degrees) => degrees * (math.pi / 180.0);

  @override
  void paint(Canvas canvas, Size size) {
    Paint backgroundPaint = Paint()
      ..color = backgroundColor
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    Paint progressPaint = Paint()
      ..color = progressColor
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    // Background Arc
    canvas.drawArc(
      Rect.fromLTWH(0, 0, size.width, size.height),
      _radians(-210),
      _radians(240),
      false,
      backgroundPaint,
    );

    // Foreground Arc
    double progressRadians = _radians(240) * progress;
    canvas.drawArc(
      Rect.fromLTWH(0, 0, size.width, size.height),
      _radians(-210),
      progressRadians,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}