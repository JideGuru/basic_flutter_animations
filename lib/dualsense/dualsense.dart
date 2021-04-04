import 'dart:ui';

import 'package:flutter/material.dart';

class DualSense extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xff518cfd), Color(0xff325de7)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            CustomPaint(
              painter: BasePainter(),
              child: Container(),
            ),
          ],
        ),
      ),
    );
  }
}


class BasePainter extends CustomPainter {

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.black
    // ..style = PaintingStyle.stroke
      ..strokeWidth = 5.0;

    var path = Path();
    path.moveTo(315.0, 353.0);
    // fix this arch
    // arch this if possible
    path.lineTo(292.0, 302.0);
    // path.quadraticBezierTo(300.0, 300.0, 295.0, 305.0);
    path.lineTo(285.0, 300.0);
    // path.lineTo(285.0, 320.0);
    path.lineTo(285.0, 293.0);
    // arch this
    // path.lineTo(280.0, 310.0);
    path.quadraticBezierTo(270.0, 285.0, 255.0, 290.0);
    path.lineTo(256.0, 295.0);
    path.quadraticBezierTo(190.0, 285.0, 140.0, 295.0);
    path.lineTo(140.0, 288.0);
    path.quadraticBezierTo(118.0, 283.0, 110.0, 292.0);
    path.lineTo(110.0, 300.0);
    // arch this if possible
    path.lineTo(104.0, 302.0);
    // path.quadraticBezierTo(95.0, 305.0, 90.0, 318.0);
    path.quadraticBezierTo(60.0, 400.0, 75.0, 450.0); /////
    path.quadraticBezierTo(95.0, 475.0, 110.0, 460.0); // 460
    // path.lineTo(130.0, 400.0);
    path.quadraticBezierTo(120.0, 420.0, 140.0, 400.0);
    // path.lineTo(155.0, 400.0);
    path.quadraticBezierTo(150.0, 395.0, 155.0, 400.0);
    // path.lineTo(160.0, 400.0);
    path.quadraticBezierTo(165.0, 405.0, 180.0, 400.0);
    path.lineTo(220.0, 400.0);
    // path.lineTo(265.0, 400.0);
    path.quadraticBezierTo(230.0, 405.0, 245.0, 400.0);
    // path.lineTo(260.0, 400.0);
    path.quadraticBezierTo(250.0, 395.0, 260.0, 400.0);
    path.quadraticBezierTo(285.0, 430.0, 290.0, 460.0);
    path.quadraticBezierTo(305.0, 475.0, 325.0, 450.0); //
    path.quadraticBezierTo(335.0, 405.0, 315.0, 353.0);
    // path.lineTo(305.0, 353.0);
    // path.close();
    canvas.drawPath(path, paint);

    // animatePath(path, paint, canvas, progress);
  }

  animatePath(Path path, Paint paint, Canvas canvas, double progress) {
    PathMetrics shadowMetrics = path.computeMetrics();
    for (PathMetric pathMetric in shadowMetrics) {
      Path extractPath = pathMetric.extractPath(
        0.0,
        pathMetric.length * progress,
      );
      canvas.drawPath(extractPath, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}