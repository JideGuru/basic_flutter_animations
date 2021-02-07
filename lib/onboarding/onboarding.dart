import 'package:flutter/material.dart';

class Onboarding extends StatefulWidget {
  @override
  _OnboardingState createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  List imgs = ['assets/1.jpg', 'assets/2.jpg', 'assets/3.jpg'];

  List<Map> captions = [
    {
      'title': 'Welcome to\nWayfarer!',
      'sub': 'We\'re glad that you\'re here. \nLet\'s get started.'
    },
    {
      'title': '',
      'sub':
          'Discover incredible cities and places\naround the world that you must visit if\nyou love to travel.'
    },
    {
      'title': '',
      'sub':
          'You can create a travel bucket-list\nand store the captures & memories of places\nas you progress.'
    },
  ];

  PageController controller1 = PageController();

  PageController controller2 = PageController();
  PageController captionController = PageController();

  int position = 0;
  int capPosition = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          ClipPath(
            clipper: ShapeClipper(),
            child: Container(
              child: PageView(
                physics: NeverScrollableScrollPhysics(),
                controller: controller1,
                reverse: true,
                children: [
                  for (String img in imgs) Image.asset(img, fit: BoxFit.cover),
                ],
              ),
            ),
          ),
          ClipPath(
            clipper: ShapeClipper(second: true),
            child: Container(
              child: PageView(
                onPageChanged: (val) {
                  changeImage(val);
                },
                controller: controller2,
                children: [
                  for (String img in imgs) Image.asset(img, fit: BoxFit.cover),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Colors.black, Colors.transparent],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    stops: [0.6, 1.0]),
              ),
              height: 270.0,
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      for (int i = 0; i < imgs.length; i++)
                        Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: AnimatedContainer(
                            duration: Duration(milliseconds: 300),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.0),
                              color:
                                  i == position ? Colors.white : Colors.white54,
                            ),
                            height: 10.0,
                            width: i == position ? 20.0 : 10.0,
                          ),
                        ),
                    ],
                  ),
                  SizedBox(height: 20.0),
                  Container(
                    height: 160.0,
                    child: PageView(
                      physics: NeverScrollableScrollPhysics(),
                      controller: captionController,
                      onPageChanged: (val) {
                        capPosition = val;
                        setState(() {});
                      },
                      children: [
                        for (Map caption in captions)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                caption['title'],
                                style: TextStyle(
                                  fontSize: 25.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: capPosition == 0 ? 20.0 : 50.0),
                              Text(
                                caption['sub'],
                                style: TextStyle(
                                  fontSize: 15.0,
                                  color: Colors.grey[300],
                                ),
                              ),
                            ],
                          )
                      ],
                    ),
                  ),
                  Visibility(
                    visible: capPosition == 2,
                    child: Stack(
                      children: [
                        Container(
                          width: (MediaQuery.of(context).size.width/2) - 15.0,
                          height: 50.0,
                          child: FlatButton(
                            shape: StadiumBorder(),
                            onPressed: () {},
                            child: Text('Register'),
                            color: Colors.grey[700],
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Container(
                            width:  (MediaQuery.of(context).size.width/2) - 15.0,
                            height: 50.0,
                            child: FlatButton(
                              shape: StadiumBorder(),
                              onPressed: () {},
                              child: Text('Log In', style: TextStyle(color: Colors.black),),
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  changeImage(int val) {
    print(val);
    print(position);
    if (val < position) {
      controller1.previousPage(
          duration: Duration(milliseconds: 400), curve: Curves.easeIn);
      captionController.previousPage(
          duration: Duration(milliseconds: 400), curve: Curves.easeIn);
    } else {
      controller1.nextPage(
          duration: Duration(milliseconds: 400), curve: Curves.easeIn);
      captionController.nextPage(
          duration: Duration(milliseconds: 400), curve: Curves.easeIn);
    }
    position = val;
    setState(() {});
    // controller2.nextPage(duration: Duration(milliseconds: 100), curve: Curves.easeIn);
  }
}

class ShapePainter extends CustomPainter {
  final bool second;

  ShapePainter({this.second = false});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    paint.color = Colors.white;

    Path path = Path();
    if (!second) {
      path.moveTo(0.0, 0.0);
      path.lineTo(size.width, 0.0);
      path.lineTo(size.width, 120.0);
      path.lineTo(0.0, size.height / 2);
    } else {
      path.moveTo(0.0, (size.height / 2) + 20.0);
      path.lineTo(size.width, 140.0);
      path.lineTo(size.width, size.height);
      path.lineTo(0.0, size.height);
    }
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class ShapeClipper extends CustomClipper<Path> {
  final bool second;

  ShapeClipper({this.second = false});

  @override
  Path getClip(Size size) {
    final double heightDelta = size.height / 2.2;

    Path path = Path();
    if (!second) {
      path.moveTo(0.0, 0.0);
      path.lineTo(size.width, 0.0);
      path.lineTo(size.width, 120.0);
      path.lineTo(0.0, size.height / 2);
    } else {
      path.moveTo(0.0, (size.height / 2) + 10.0);
      path.lineTo(size.width, 130.0);
      path.lineTo(size.width, size.height);
      path.lineTo(0.0, size.height);
    }
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
