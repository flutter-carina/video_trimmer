import 'package:flutter/material.dart';



class TrimEditorPainter extends CustomPainter {
  final Offset startPos;
  final Offset endPos;
  final double scrubberAnimationDx;
  final double scrubberWidth;
  final bool showScrubber;
  final Color handleColor;
  final Color scrubberPaintColor;

  TrimEditorPainter({
    required this.startPos,
    required this.endPos,
    required this.scrubberAnimationDx,
    this.scrubberWidth = 2,
    this.showScrubber = true,
    this.handleColor = Colors.white,
    this.scrubberPaintColor = Colors.white,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final handlePaint = Paint()
      ..color = handleColor
      ..style = PaintingStyle.fill;

    final linePaint = Paint()
      ..color = Colors.grey
      ..strokeWidth = 2;

    final scrubberPaint = Paint()
      ..color = scrubberPaintColor
      ..strokeWidth = scrubberWidth
      ..style = PaintingStyle.stroke;

    // Left handle rect
    final leftHandleRect = Rect.fromLTWH(
      startPos.dx - 12,
      startPos.dy,
      24,
      endPos.dy,
    );
    final leftRRect = RRect.fromRectAndCorners(
      leftHandleRect,
      topLeft: const Radius.circular(12),
      bottomLeft: const Radius.circular(12),
    );
    canvas.drawRRect(leftRRect, handlePaint);

    // Add grey line inside left handle
    final leftCenterX = leftHandleRect.center.dx;
    canvas.drawLine(
      Offset(leftCenterX, startPos.dy + 15),
      Offset(leftCenterX, endPos.dy - 15),
      linePaint,
    );

    // Right handle rect
    final rightHandleRect = Rect.fromLTWH(
      endPos.dx - 12,
      startPos.dy,
      24,
      endPos.dy,
    );
    final rightRRect = RRect.fromRectAndCorners(
      rightHandleRect,
      topRight: const Radius.circular(12),
      bottomRight: const Radius.circular(12),
    );
    canvas.drawRRect(rightRRect, handlePaint);

    // Add grey line inside right handle
    final rightCenterX = rightHandleRect.center.dx;
    canvas.drawLine(
      Offset(rightCenterX, startPos.dy + 15),
      Offset(rightCenterX, endPos.dy - 15),
      linePaint,
    );

    // Scrubber line
    if (showScrubber &&
        scrubberAnimationDx > startPos.dx &&
        scrubberAnimationDx < endPos.dx) {
      canvas.drawLine(
        Offset(scrubberAnimationDx, startPos.dy),
        Offset(scrubberAnimationDx, endPos.dy),
        scrubberPaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
