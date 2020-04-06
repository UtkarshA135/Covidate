import 'package:flutter/material.dart';
import 'card_list.dart';
class CustomCard extends StatelessWidget {
  final String name;
  final String url;
  CustomCard({this.name,this.url});
 
  @override
  Widget build(BuildContext context) {
    bool isLiked = false;
    return  Card(
                                       child : Column(children: <Widget>[
                                         Container(
                                       width: 700.0,
                                       height: 400.0,
                                       decoration: BoxDecoration(
                                           borderRadius: BorderRadius.circular(10.0),
                                           image: DecorationImage(
                                               image:url != null ? NetworkImage(url) : Container(),
                                               fit: BoxFit.cover)),
                                                child: Column(children: <Widget>[
                                      
                                                 Expanded(child:   Align(  alignment: FractionalOffset.bottomCenter, child:  Text(name,
                                                style : TextStyle(
                                                 // fontFamily: 'IndieFlower',
                                                   fontWeight : FontWeight.bold,
                                                   color:  Colors.white,
                                                   fontSize: 40.0, 
                                                 )
                                                ),),)
                                    ],)
                                     ),
                                      /* Positioned(
                                       top: 320.0,
                                       left: 15.0,
                                       child: Container(
                                       //  transform: Matrix4.translationValues(0.0, infoAnimation.value * devHeight, 0.0),
                                         width: 270.0,
                                         height: 90.0,
                                         decoration: BoxDecoration(
                                             borderRadius: BorderRadius.circular(10.0),
                                             color: Colors.white,
                                             boxShadow: [
                                               BoxShadow(
                                                   blurRadius: 1.0,
                                                   color: Colors.black12,
                                                   spreadRadius: 2.0)
                                             ]),
                                         child: Container(
                                           padding: EdgeInsets.all(7.0),
                                           child: Column(
                                             mainAxisAlignment: MainAxisAlignment.center,
                                             children: <Widget>[
                                               Row(
                                                 children: <Widget>[
                                                   Text(
                                                     cards[x].name,
                                                     style: TextStyle(
                                                         fontFamily: 'IndieFlower',
                                                         fontSize: 20.0),
                                                   ),
                                                   SizedBox(width: 4.0),
                                                   Image.asset(
                                                     'assets/virat.jpg',
                                                     height: 20.0,
                                                     width: 20.0,
                                                   ),
                                                   SizedBox(width: 110.0),
                                                   Text(
                                                     cards[x].dis,
                                                     style: TextStyle(
                                                         fontFamily: 'IndieFlower',
                                                         fontSize: 20.0,
                                                         color: Colors.grey),
                                                   ),
                                                 ],
                                               ),
                                               SizedBox(height: 9.0),
                                               Row(
                                                 children: <Widget>[
                                                   Text(
                                                     cards[x].bio,
                                                     style: TextStyle(
                                                         fontFamily: 'IndieFlower',
                                                         fontSize: 15.0,
                                                         color: Colors.grey),
                                                   )
                                                 ],
                                               )
                                             ],
                                           ),
                                         ),
                                       ),
                                     )*/
                                       ],),
                                 );
                 
                                
                                 
                               
                                 
                                 
                                  
                                  
                       
                   
                 
               }
             
}