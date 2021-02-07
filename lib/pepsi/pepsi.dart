import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';

class Pepsi extends StatefulWidget {
  @override
  _PepsiState createState() => _PepsiState();
}

class _PepsiState extends State<Pepsi> with TickerProviderStateMixin {
  AnimationController cupController;
  AnimationController coverController;
  AnimationController coverTopController;
  AnimationController strawController;
  AnimationController shadowController;
  AnimationController fadeController;
  AnimationController filledController;

  Animation<double> cupAnimation;
  Animation<double> coverAnimation;
  Animation<double> coverTopAnimation;
  Animation<double> strawAnimation;
  Animation<double> shadowAnimation;
  Animation<double> fadeAnimation;
  Animation<double> filledAnimation;

  Color pepsiColor = Color(0xff15549a);

  @override
  void initState() {
    super.initState();
    shadowController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    cupController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    coverController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    coverTopController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    strawController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    fadeController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    filledController =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    cupAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(cupController);
    shadowAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(shadowController);

    Timer(Duration(seconds: 1), () {
      cupController.forward();
      shadowController.forward();
    });
    cupController.addListener(() {
      if (cupAnimation.value == 1) {
        coverController.forward();
        coverAnimation =
            Tween<double>(begin: 0.0, end: 1.0).animate(coverController);
      }
      setState(() {});
    });
    coverController.addListener(() {
      if (coverAnimation.value == 1) {
        coverTopController.forward();
        coverTopAnimation =
            Tween<double>(begin: 0.0, end: 1.0).animate(coverTopController);
      }
      setState(() {});
    });

    coverTopController.addListener(() {
      if (coverTopAnimation.value == 1) {
        strawController.forward();
        strawAnimation =
            Tween<double>(begin: 0.0, end: 1.0).animate(strawController);
      }
      setState(() {});
    });

    strawController.addListener(() {
      if (strawAnimation.value == 1) {
        fadeController.forward();
        fadeAnimation =
            Tween<double>(begin: 0.0, end: 1.0).animate(fadeController);
      }
      setState(() {});
    });
    shadowController.addListener(() {
      setState(() {});
    });
    fadeController.addListener(() {
      if (fadeAnimation.value > 0.5) {
        filledController.forward();
        filledAnimation =
            Tween<double>(begin: 0.0, end: 1000.0).animate(filledController);
      }
      setState(() {});
    });
    filledController.addListener(() {
      setState(() {});
    });
  }

  List<Offset> animList1 = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CustomPaint(
            painter: CupPainter(
              cupProgress: cupAnimation.value,
              coverProgress: coverAnimation?.value ?? 0,
              coverTopProgress: coverTopAnimation?.value ?? 0,
              strawProgress: strawAnimation?.value ?? 0,
              shadowProgress: shadowAnimation?.value ?? 0,
            ),
            child: Container(),
          ),
          ClipPath(
            clipper: DrinkClipper(),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.bottomCenter,
                  child: ClipPath(
                    clipper: DrinkClipper(),
                    child: Container(
                      color: pepsiColor,
                      height: filledAnimation?.value ?? 0,
                    ),
                  ),
                ),
              ],
            ),
          ),
          AnimatedOpacity(
            opacity: fadeAnimation?.value ?? 0,
            duration: Duration(seconds: 1),
            child: Center(
              child: Padding(
                padding: EdgeInsets.only(top: 50.0, left: 5.0),
                child:
                    Image.asset('assets/pepsi.png', height: 80.0, width: 80.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CupPainter extends CustomPainter {
  final double cupProgress;
  final double coverProgress;
  final double coverTopProgress;
  final double strawProgress;
  final double shadowProgress;

  CupPainter(
      {this.cupProgress,
      this.coverProgress,
      this.coverTopProgress,
      this.strawProgress,
      this.shadowProgress});

  @override
  void paint(Canvas canvas, Size size) {
    var cupPaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 2.5;

    var coverPaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0;

    var whitePaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    var shadowPaint = Paint()
      ..color = Colors.grey[800]
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0
      ..maskFilter = MaskFilter.blur(BlurStyle.solid, convertRadiusToSigma(3));

    // Draw Cup
    Path cupPath = Path()
      ..moveTo(size.width / 2.9, size.height / 2.39)
      ..lineTo(size.width / 2.5, size.height / 1.5)
      ..quadraticBezierTo(size.width / 2.46, size.height / 1.489,
          size.width / 2.34, size.height / 1.484)
      ..lineTo(size.width / 1.7, size.height / 1.484)
      ..quadraticBezierTo(size.width / 1.64, size.height / 1.489,
          size.width / 1.63, size.height / 1.5)
      ..lineTo(size.width / 1.5, size.height / 2.39)
      ..close();

    // Animate Cup
    animatePath(cupPath, cupPaint, canvas, cupProgress);

    // Draw Shadow Line
    Path shadowPath = Path()
      ..moveTo(size.width / 2.5, size.height / 1.475)
      ..lineTo(size.width / 1.388, size.height / 1.475);

    // Animate Shadow
    animatePath(shadowPath, shadowPaint, canvas, shadowProgress);

    // Draw Cup Cover
    Path coverPath = Path()
      ..moveTo(size.width / 1.51, size.height / 2.39)
      ..lineTo(size.width / 1.39, size.height / 2.39)
      ..lineTo(size.width / 1.41, size.height / 2.515)
      ..lineTo(size.width / 3.34, size.height / 2.515)
      ..lineTo(size.width / 3.4, size.height / 2.39)
      ..lineTo(size.width / 2.88, size.height / 2.39)
      ..close();

    // Animate Cup Cover
    animatePath(coverPath, coverPaint, canvas, coverProgress);

    // Draw Cup Cover top
    Path coverTopPath = Path()
      ..moveTo(size.width / 2.94, size.height / 2.515)
      ..lineTo(size.width / 2.88, size.height / 2.655)
      ..lineTo(size.width / 1.53, size.height / 2.655)
      ..lineTo(size.width / 1.499, size.height / 2.515);

    // Animate Cup Cover Top
    animatePath(coverTopPath, coverPaint, canvas, coverTopProgress);

    // Draw Straw
    Path strawPath = Path()
      ..moveTo(size.width / 1.87, size.height / 2.66)
      ..lineTo(size.width / 1.829, size.height / 2.9)
      ..lineTo(size.width / 1.7, size.height / 2.96)
      ..lineTo(size.width / 1.689, size.height / 2.9)
      ..lineTo(size.width / 1.78, size.height / 2.84)
      ..lineTo(size.width / 1.811, size.height / 2.66);

    // Animate straw
    animatePath(strawPath, coverPaint, canvas, strawProgress);

    // The little white space in the straw/cover
    // top
    Path whitePath = Path()
      ..moveTo(size.width / 1.85, size.height / 2.671)
      ..lineTo(size.width / 1.829, size.height / 2.671);
    canvas.drawPath(whitePath, whitePaint);
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

  static double convertRadiusToSigma(double radius) {
    return radius * 0.57735 + 0.5;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class DrinkClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    print(size.width / 1.506);
    Path cupPath = Path()
      ..moveTo(size.width / 2.88, size.height / 2.38)
      ..lineTo(size.width / 2.5, size.height / 1.5)
      ..quadraticBezierTo(size.width / 2.46, size.height / 1.489,
          size.width / 2.34, size.height / 1.484)
      ..lineTo(size.width / 1.7, size.height / 1.484)
      ..quadraticBezierTo(size.width / 1.64, size.height / 1.489,
          size.width / 1.63, size.height / 1.5)
      ..lineTo(size.width / 1.506, size.height / 2.38)
      ..close();
    return cupPath;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
