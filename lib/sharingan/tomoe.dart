import 'package:flutter/material.dart';

class Tomoe extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: CustomPaint(painter: _TomoePainter())),
    );
  }
}



class _TomoePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()..color = Colors.black;
    Offset center = Offset(size.width / 2, size.height / 2);
    canvas.drawCircle(center, 10.0, paint);
    Path path = Path();
    var tip = Paint()..color = Colors.red ..style = PaintingStyle.stroke ..strokeWidth = 3.0;
    path.moveTo((size.width / 2), (size.height / 2) - 25);
    path.quadraticBezierTo((size.width / 2) - 20, (size.height / 2) -10, (size.width / 2) - 7, (size.height / 2) +5);
    path.lineTo((size.width / 2) , (size.height / 2));
    path.quadraticBezierTo((size.width / 2) - 15, (size.height / 2) - 10, (size.width / 2), (size.height / 2) - 25);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}