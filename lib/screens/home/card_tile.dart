import 'package:flutter/material.dart';
import 'package:covidate/models/cards.dart';
class CardTile extends StatelessWidget {
  final Cards card;
  final bool showlike;
  CardTile({this.card,this.showlike});
  @override
  Widget build(BuildContext context) {
 return   Stack(children: <Widget>[
                            Container(
                          width: 700.0,
                          height: 300.0,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              image: DecorationImage(
                                  image: NetworkImage(card.url),
                                  fit: BoxFit.cover)),
                                   child: Column(children: <Widget>[
                         
                                    Expanded(child:   Align(  alignment: FractionalOffset.bottomCenter, child:  Text(card.name,
                                   style : TextStyle(
                                    // fontFamily: 'IndieFlower',
                                      fontWeight : FontWeight.bold,
                                      color:  Colors.red,
                                      fontSize: 40.0, 
                                    )
                                   ),),)
                       ],)
                        ),
                 
                          ],);
    
  }
}