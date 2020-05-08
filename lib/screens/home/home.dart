import 'package:flutter/material.dart';
import 'package:covidate/services/auth.dart';
import 'all_users_screen.dart';
import 'profile.dart';
import 'card_list.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:covidate/services/database.dart';
import 'package:covidate/models/cards.dart';
import 'cardlist.dart';
import 'package:covidate/screens/home/background.dart';
import 'package:covidate/screens/home/credits.dart';
import 'package:covidate/screens/home/help.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:neumorphic/neumorphic.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
 
   final globalKey = GlobalKey<ScaffoldState>();
  final AuthService _auth = AuthService();

  showCredits(){
    setState(() {
      Navigator.push(context, MaterialPageRoute(builder: (context) => Credits()));
    });
  }
  showHelp(){
    setState(() {
      Navigator.push(context, MaterialPageRoute(builder: (context) => Help()));
    });
  }
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, allowFontScaling: true);
    return StreamProvider<List<Cards>>.value(
           value : DatabaseService().cards,
          child: Scaffold(
             key: globalKey,
            
        backgroundColor: Colors.white,
        // appBar: AppBar(
        //   title : Text('Home'),
        //   backgroundColor : Colors.pink[800],
        //   actions: <Widget>[
        //      FlatButton.icon(onPressed: () async {
        //       await _auth.signOut();
        //     }, icon: Icon(Icons.person), label: Text('Log out'))
        //             ],),
          
          
        
      //  body: CardLiist(),
     body: SafeArea(
                child: Stack(
           children: <Widget>[
              Column(
                children: <Widget>[
                  Container(
                    // color: Colors.white10,
                    alignment: Alignment.topLeft,
                    padding: EdgeInsets.all(10.0),
                    margin: EdgeInsets.all(0.0),
                    height: ScreenUtil().setHeight(210.0),
                    width: ScreenUtil().setWidth(210.0),
                    child: NeuButton(
                                  //color: Colors.white,
                                  child: Icon(Icons.info_outline),
                                  onPressed: ()=> showCredits(),
                                  decoration: NeumorphicDecoration(
                                     shape: BoxShape.circle ,
                                    color: Colors.white
                                   )
                                  // icon: Icon(Icons.edit),
                                  // label: Text('Edit Profile')
                                  ),
                  ),
                  Text('Credits',
                  style: TextStyle(
                    fontFamily: 'Lobster',
                    color: Colors.grey[700],
                  ),
                  )
                ],
              ),
              Column(
                children: <Widget>[
                  Container(
                    color: Colors.white,
                    alignment: Alignment.topLeft,
                    padding: EdgeInsets.all(0.0),
                    margin: EdgeInsets.only(left:ScreenUtil().setWidth(240.0), top: ScreenUtil().setHeight(30.0)),
                    height: ScreenUtil().setHeight(150.0),
                    width: ScreenUtil().setWidth(150.0),
                    child: NeuButton(
                                  //color: Colors.white,
                                  child: Icon(Icons.help_outline),
                                  onPressed: ()=> showHelp(),
                                  decoration: NeumorphicDecoration(
                                     shape: BoxShape.circle ,
                                    color: Colors.white
                                   )
                                  ),
                  ),
              Container(
                    margin: EdgeInsets.only(left:ScreenUtil().setWidth(240.0), top: ScreenUtil().setHeight(30.0)),
                child: Text('Help',
                style: TextStyle(
                    fontFamily: 'Lobster',
                    color: Colors.grey[700],
                 ),
                )
                ),
                ],
              ),

             Stack(
               children: <Widget>[
                //  SizedBox(width: 300.0, height: 50.0,),
                 Container(
                   alignment: Alignment.topRight,
                   child: HomeCirclePink()),
                 Container(
                   alignment: Alignment.topRight,
                  padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(80.0) , vertical: ScreenUtil().setHeight(135.0)),       
                   child: SvgPicture.network('https://www.svgrepo.com/show/292432/couple-love.svg', height: ScreenUtil().setHeight(200.0),),
                  //  child: SvgPicture.asset('assets/SteveLambert-Michelle-Kempner-Reading.svg',height: 95.0,)
                   ),
                   Container(
                       alignment: Alignment.topCenter,
                  margin: EdgeInsets.only(left: ScreenUtil.screenWidth*0.4 , 
                  // vertical: ScreenUtil().setHeight(135.0)
                  ),
                     color: Colors.pink,
                     width: ScreenUtil().setWidth(30.0) ,
                     height: ScreenUtil().setHeight(135.0)
                     ),


               ],
             ),
             Stack(
               children: <Widget>[
                //  SizedBox(width: 300.0, height: 50.0,),
                 Container(
                   alignment: Alignment.topRight,
                   child: HomeCircleYellow()),
                 Container(
                  alignment: Alignment.topRight,
                   padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(360.0) , vertical: ScreenUtil().setHeight(265.0)),     
                 child: SvgPicture.network('https://www.svgrepo.com/show/236854/gift-couple.svg', height: ScreenUtil().setHeight(200.0),),                 //  child: SvgPicture.asset('assets/SteveLambert-Michelle-Kempner-Reading.svg',height: 95.0,)
                   ),
                   Container(
                       alignment: Alignment.topCenter,
                  margin: EdgeInsets.only(left: ScreenUtil.screenWidth*0.275 , 
                  // vertical: ScreenUtil().setHeight(135.0)
                  ),
                     color: Colors.yellow,
                     width: ScreenUtil().setWidth(30.0) ,
                     height: ScreenUtil().setHeight(265.0)
                     ),

               ],
           ),

             Column(
               mainAxisAlignment: MainAxisAlignment.center,
               crossAxisAlignment: CrossAxisAlignment.start,
               children: <Widget>[
                 Padding(
                   padding: const EdgeInsets.only(left: 8.0),
                   child: Text(
               'Choose Your Date:',
               style: TextStyle(
                      // color: Colors.white,
                     fontSize: 20.0,
                     fontWeight: FontWeight.w400,
                     fontFamily: 'Lobster',
                      decoration: TextDecoration.overline,
                      ),
                   ),
                 ),
                 SizedBox(
                   height: MediaQuery.of(context).size.height*0.2,
                 ),
                 Container(
                   alignment: Alignment.center,
                   child: Image.network('https://stayhipp.com/wp-content/uploads/2019/09/sully.jpg'),

                   ),
                  //  Text('Nothing Left')
               ],
             ),
             CardLiist(),
           ],
         ),
       ),
                     ),
    );
                   
                 }
}