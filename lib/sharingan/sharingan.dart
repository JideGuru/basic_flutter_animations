import 'dart:async';

import 'package:flutter/material.dart';

class SharinganLoader extends StatefulWidget {
  @override
  _SharinganLoaderState createState() => _SharinganLoaderState();
}

class _SharinganLoaderState extends State<SharinganLoader>
    with SingleTickerProviderStateMixin {
  AnimationController _tomoeController;
  bool shrink = false;

  @override
  void initState() {
    super.initState();
    _tomoeController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    Timer(Duration(seconds: 2), () {
      _tomoeController.forward();
      shrink = true;
      setState(() {});
    });

    _tomoeController.addListener(() async {
      if (_tomoeController.value == 1.0) {
        await Future.delayed(Duration(milliseconds: 300));
        shrink = false;
        setState(() {});
        _tomoeController.reverse();
      } else if (_tomoeController.value == 0.0) {
        await Future.delayed(Duration(milliseconds: 300));

        shrink = true;
        setState(() {});
        _tomoeController.forward();
      }
    });
  }

  @override
  void dispose() {
    _tomoeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Transform.rotate(
          angle: 1.0,
          child: AnimatedContainer(
            duration: Duration(seconds: 1),
            height: shrink ? 160.0 : 200.0,
            width: shrink ? 160.0 : 200.0,
            decoration: BoxDecoration(
                color: Colors.black,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                      blurRadius: 10.0,
                      spreadRadius: 10.0,
                      color: Colors.white24),
                ]),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AnimatedContainer(
                  duration: Duration(seconds: 1),
                  height: shrink ? 140.0 : 180.0,
                  width: shrink ? 140.0 : 180.0,
                  decoration: BoxDecoration(
                    color: Color(0xffA50C0E),
                    shape: BoxShape.circle,
                  ),
                  child: RotationTransition(
                    turns: Tween(begin: shrink ? 1.0 : 2.5, end: 0.0)
                        .animate(_tomoeController),
                    child: Stack(
                      children: [
                        Center(
                          child: AnimatedContainer(
                            duration: Duration(seconds: 1),
                            height: 30.0,
                            width: 30.0,
                            decoration: BoxDecoration(
                              color: Colors.black,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                        Center(
                          child: Transform.rotate(
                            angle: 0.5,
                            child: RotatingCircle(shrink: shrink),
                          ),
                        ),
                        Center(
                          child: Transform.rotate(
                            angle: 2.7,
                            child: RotatingCircle(shrink: shrink),
                          ),
                        ),
                        Center(
                          child: Transform.rotate(
                            angle: 4.7,
                            child: RotatingCircle(shrink: shrink),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Tomoe extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Transform.rotate(
        angle: -1.5,
        child: CustomPaint(painter: _TomoePainter()),
      ),
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
    path.moveTo((size.width / 2), (size.height / 2) - 25);
    path.quadraticBezierTo((size.width / 2) - 20, (size.height / 2) - 10,
        (size.width / 2) - 7, (size.height / 2) + 5);
    path.lineTo((size.width / 2), (size.height / 2));
    path.quadraticBezierTo((size.width / 2) - 15, (size.height / 2) - 10,
        (size.width / 2), (size.height / 2) - 25);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class RotatingCircle extends StatelessWidget {
  final bool shrink;

  RotatingCircle({this.shrink});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(seconds: 1),
      height: shrink ? 90.0 : 120.0,
      width: shrink ? 90.0 : 120.0,
      decoration: BoxDecoration(
        color: Colors.transparent,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.black, width: 2.0),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(child: _Tomoe(), top: 0.0, bottom: 0.0),
        ],
      ),
    );
  }
}
