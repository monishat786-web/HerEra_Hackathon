import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import '../constants/app_colors.dart';

class TamilNaduMapPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey.withValues(alpha: 0.1)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    // Drawing some mock road grid
    for (int i = 0; i < size.width; i += 40) {
      canvas.drawLine(Offset(i.toDouble(), 0), Offset(i.toDouble(), size.height), paint);
    }
    for (int i = 0; i < size.height; i += 40) {
      canvas.drawLine(Offset(0, i.toDouble()), Offset(size.width, i.toDouble()), paint);
    }

    // Drawing a purple route
    final pathPaint = Paint()
      ..color = AppColors.primary.withValues(alpha: 0.6)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0
      ..strokeCap = StrokeCap.round;

    final path = ui.Path();
    path.moveTo(0, size.height * 0.8);
    path.lineTo(size.width * 0.8, size.height * 0.2);
    canvas.drawPath(path, pathPaint);

    // Hazard Zones
    final hazardPaint = Paint()..color = AppColors.highRisk.withValues(alpha: 0.2);
    canvas.drawCircle(Offset(size.width * 0.3, size.height * 0.4), 30, hazardPaint);
    
    final cautionPaint = Paint()..color = AppColors.caution.withValues(alpha: 0.2);
    canvas.drawCircle(Offset(size.width * 0.7, size.height * 0.6), 40, cautionPaint);

    // Chennai label simulation
    const textStyle = TextStyle(color: Colors.black54, fontSize: 10, fontWeight: FontWeight.bold);
    final textPainter = TextPainter(
      text: const TextSpan(text: "CHENNAI", style: textStyle),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(canvas, Offset(size.width * 0.7, size.height * 0.15));
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
