import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
const List<Color> aquaGradients = [
  Color(0xFF5AEAF1),
  Color(0xFF8EF7DA),
];



class WavyFooter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: FooterWaveClipper(),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: aquaGradients,
              begin: Alignment.center,
              end: Alignment.bottomRight),
        ),
        height: MediaQuery.of(context).size.height / 3,
      ),
    );
  }
}

class CirclePink extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(-70.0, 90.0),
      child: Material(
        color: Colors.pink,
        child: Padding(padding: EdgeInsets.all(120)),
        shape: CircleBorder(side: BorderSide(color: Colors.white, width: 15.0)),
      ),
    );
  }
}
// class CircleAqua extends StatelessWidget {
// +  @override
// +  Widget build(BuildContext context) {
// +    return Transform.translate(
// +      offset: Offset(170.0, 110.0),
// +      child: Container(
// +        decoration: ShapeDecoration(
// +          shape: CircleBorder(side: BorderSide(color: Colors.white, width: 15.0)),
// +          gradient: LinearGradient(
// +              colors: aquaGradients,
// +              begin: Alignment.center,
// +              end: Alignment.bottomRight),
// +        ),
// +        child: Padding(padding: EdgeInsets.all(120)),
// +      ),
// +    );
// +  }
// +}
// +}
class HomeCirclePink extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Transform.translate(
     offset: Offset(ScreenUtil().setWidth(-15.0), ScreenUtil().setHeight(77.0)),
      child: Material(
        color: Colors.pink,
        child: Padding(padding: EdgeInsets.all(ScreenUtil().setWidth(180))),
       shape: CircleBorder(side: BorderSide(color: Colors.white, width: ScreenUtil().setWidth(45.0))),
      ),
    );
 }
}
class CredCirclePink extends StatelessWidget {
  @override
 Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(ScreenUtil().setWidth(250.0), ScreenUtil().setHeight(190.0)),
      // offset: Offset(ScreenUtil().setWidth(-355.0), ScreenUtil().setHeight(89.0)),
      child: Material(
       color: Colors.pink,
        child: Padding(padding: EdgeInsets.all(ScreenUtil().setWidth(180))),
        shape: CircleBorder(side: BorderSide(color: Colors.white, width: ScreenUtil().setWidth(45.0))),
      ),
    );
  }
}
class HomeCircleYellow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(ScreenUtil().setWidth(-260.0), ScreenUtil().setHeight(190.0)),
      child: Material(
        color: Colors.yellow,
        child: Padding(padding: EdgeInsets.all(ScreenUtil().setWidth(210))),
        shape: CircleBorder(side: BorderSide(color: Colors.white, width: ScreenUtil().setWidth(45.0))),
      ),
    );
  }
}
class CredCircleYellow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Transform.translate(
       offset: Offset(ScreenUtil().setWidth(-65.0), ScreenUtil().setHeight(230.0)),
      // offset: Offset(ScreenUtil().setWidth(-150.0), ScreenUtil().setHeight(190.0)),
      child: Material(
        color: Colors.yellow,
        child: Padding(padding: EdgeInsets.all(ScreenUtil().setWidth(210))),
        shape: CircleBorder(side: BorderSide(color: Colors.white, width: ScreenUtil().setWidth(45.0))),
      ),
    );
  }
}

class CircleYellow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(0.0, 210.0),
      child: Material(
        color: Colors.yellow,
        child: Padding(padding: EdgeInsets.all(140)),
        shape: CircleBorder(side: BorderSide(color: Colors.white, width: 15.0)),
      ),
    );
  }
}



class FooterWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.moveTo(size.width, 0.0);
    path.lineTo(size.width, size.height);
    path.lineTo(0.0, size.height);
    path.lineTo(0.0, size.height - 60);
    var secondControlPoint = Offset(size.width - (size.width / 6), size.height);
    var secondEndPoint = Offset(size.width, 0.0);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class YellowCircleClipper extends CustomClipper<Rect> {
  @override
  Rect getClip(Size size) {
    return null;
  }

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) => false;
}