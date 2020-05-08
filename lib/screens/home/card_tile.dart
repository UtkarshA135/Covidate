import 'package:flutter/material.dart';
import 'package:covidate/models/cards.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class CardTile extends StatelessWidget {
  final Cards card;
 
  CardTile({this.card});
  @override
  Widget build(BuildContext context) {
 return   Stack(children: <Widget>[
                            Container(
                          // width: 700.0,
                          // height: 300.0,
                          width: ScreenUtil().setWidth(1000.0),
                         height: ScreenUtil().setHeight(900.0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              image: DecorationImage(
                                  // image: NetworkImage(card.url),
                                  image: card.url ==null? AssetImage('assets/virat.jpg'):NetworkImage(card.url),
                                  fit: BoxFit.cover)),
                      //              child: Column(children: <Widget>[
                         
                      //               Expanded(child:   Align(  alignment: FractionalOffset.bottomCenter, child:  Text(card.name,
                      //              style : TextStyle(
                      //               // fontFamily: 'IndieFlower',
                      //                 fontWeight : FontWeight.bold,
                      //                 color:  Colors.red,
                      //                 fontSize: 40.0, 
                      //               )
                      //              ),),)
                      //  ],)
                      child: Column(
                                     children: <Widget>[
                                       Row(children: <Widget>[
                                       Expanded(
                                         child:   Align(  
                                        alignment: FractionalOffset.topLeft,
                                        child:  Text(
                                          // card.name+' , '+ 
                                          card.age.toString(),
                                       style : TextStyle(
                                        // fontFamily: 'IndieFlower',
                                          fontWeight : FontWeight.bold,
                                          color:  Colors.red,
                                         fontSize: 40.0, 
                                       )
                                       ),

                                       ),),
                                       Container(
                                         color: Colors.black,
                                         padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(50.0), vertical: ScreenUtil().setHeight(30.0)),
                                         child:   Align(  
                                        alignment: FractionalOffset.topRight,
                                       child:  Text(
                                          card.name, 
                                          // card.age.toString(),
                                       style : TextStyle(
                                        // fontFamily: 'IndieFlower',
                                        fontFamily: 'Lobster',
                                          // fontWeight : FontWeight.bold,
                                          color:  Colors.white,
                                          fontSize: ScreenUtil().setSp(55.0), 
                                        )
                                       ),

                                       ),)
                       ],),
                                     Expanded(
                                        child: Align(  
                                          alignment: FractionalOffset.bottomCenter,
                                          child:  Container(
                                            width: ScreenUtil().setWidth(1000.0),
                                            color: Colors.white,
                                            child: Text(
                                         card.bio, 
                                        textAlign: TextAlign.center,
                                         // card.age.toString(),
                                         style : TextStyle(
                                         fontFamily: 'Pacifico',
                                        //  fontWeight : FontWeight.bold,
                                         color:  Colors.black,
                                         fontSize: ScreenUtil().setSp(75.0), 
                                            )
                                         ),
                                          ),

                                         ),
                                     )
                                     ],
                                   )
                       ),
                 
                          ],);
    
  }
}
