import 'package:covidate/screens/home/background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Help extends StatefulWidget {
  @override
  _HelpState createState() => _HelpState();
}

class _HelpState extends State<Help>  with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<Offset> _offsetAnimation;
  @override
   void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..forward();
    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0.5, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));
  }
  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Help', 
        style: TextStyle(
          fontFamily: 'Lobster',
        ),
        ),
        centerTitle: true,
        backgroundColor: Colors.pink[800],
      ),
      body: SingleChildScrollView(
              child: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
             SlideTransition(
               position: _offsetAnimation,
               child: Stack(
                 children: <Widget>[
                   Stack(
                   children: <Widget>[
                       Container(
                           alignment: Alignment.topLeft,
                      margin: EdgeInsets.only(left: ScreenUtil.screenWidth*0.06 , 
                      // vertical: ScreenUtil().setHeight(135.0)
                      ),
                         color: Colors.yellow,
                         width: ScreenUtil().setWidth(30.0) ,
                         height: ScreenUtil().setHeight(335.0)
                         ),
                     CredCircleYellow(),
                     Container(
                     alignment: Alignment.topLeft,
                        padding: EdgeInsets.only(left: ScreenUtil().setWidth(30.0) , top: ScreenUtil().setHeight(320.0)),
                     child: SvgPicture.network('https://www.svgrepo.com/show/236854/gift-couple.svg', height: ScreenUtil().setHeight(200.0),),
                        //  child: SvgPicture.asset('assets/SteveLambert-Michelle-Kempner-Reading.svg',height: 95.0,)
                     ),
                         
                       
                   ],
                       ),
                  Stack(
                  children: <Widget>[
                      Container(
                          alignment: Alignment.topCenter,
                     margin: EdgeInsets.only(left: ScreenUtil.screenWidth*0.19 , 
                     // vertical: ScreenUtil().setHeight(135.0)
                     ),
                        color: Colors.pink,
                        width: ScreenUtil().setWidth(30.0) ,
                        height: ScreenUtil().setHeight(265.0)
                        ),
                     CredCirclePink(),
                   Container(
                   alignment: Alignment.topLeft,
                   
                    padding: EdgeInsets.only(left: ScreenUtil().setWidth(317.0) , top: ScreenUtil().setHeight(247.0)),
                   child: SvgPicture.network('https://www.svgrepo.com/show/292432/couple-love.svg', height: ScreenUtil().setHeight(200.0),),
                    // child: SvgPicture.network('https://www.svgrepo.com/show/303615/github-icon-1-logo.svg', height: ScreenUtil().setHeight(200.0),),
                   //  child: SvgPicture.asset('assets/SteveLambert-Michelle-Kempner-Reading.svg',height: 95.0,)
                    ),
                    
                        
                      
                  ],
                 ),
                 ],
               ),
             ), 
              Container(
                margin:EdgeInsets.only(top: 30.0),
               padding: EdgeInsets.all(16.0),
               child: Text(
                 'Covidate is to find your match ;) \n\n Right Swipe if you think you found your perfect one \n\n Left Swipe if you are not interested \n\n You will be matched with someone if both of you right swiped each other\n\n If you match with someone, the chat feature will open, and you can share your love',
                 style: TextStyle(
                   fontSize: ScreenUtil().setSp(60.0),
                  //  fontWeight: FontWeight.w00,
                  letterSpacing: 1.0,
                  //  fontFamily: 'Signatra',
                  // fontFamily: 'Courgette',
                 ),
               ),
                ),
            ],),
              ),
      ),
    );
  }
}
