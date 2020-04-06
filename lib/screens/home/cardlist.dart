import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'card_tile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covidate/models/cards.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';
class CardLiist extends StatefulWidget {
  @override
  _CardLiistState createState() => _CardLiistState();
}

class _CardLiistState extends State<CardLiist> {
  final globalKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final users = Provider.of<List<Cards>>(context) ;
      
    CardController controller;
    return  TinderSwapCard(
          
                  orientation: AmassOrientation.BOTTOM,
                  totalNum: users.length,
                  stackNum: 8,
                  swipeEdge: 4.0,
                  maxWidth: MediaQuery.of(context).size.width * 0.9,
                  maxHeight: MediaQuery.of(context).size.width * 0.9,
                  minWidth: MediaQuery.of(context).size.width * 0.8,
                  minHeight: MediaQuery.of(context).size.width * 0.8,
                  cardBuilder: (context,index){
                  
                    return  CardTile(card : users[index]);
                  },
              cardController: controller = CardController(),
                  swipeUpdateCallback:
                      (DragUpdateDetails details, Alignment align) {
                    /// Get swiping card's alignment
                    if (align.x < 0) {
                      //Card is LEFT swiping
                        final snackbar = SnackBar(content: Row(
        
       children:<Widget>[
         
         Icon(Icons.not_interested,
         color : Colors.red[900],
         size: 40.0,
         ),
         SizedBox(width : 5.0),
         Text('Nope',
         style : TextStyle(
           fontSize: 40.0,
            color : Colors.greenAccent[100],
            fontWeight: FontWeight.bold,
         )),
       ],),
       duration: Duration(seconds : 1),
       backgroundColor: Colors.white,
     );
                    globalKey.currentState.showSnackBar(snackbar);
                      print('Swipe left');
                    } else if (align.x > 0) {
                      //Card is RIGHT swiping
                        final snackbar = SnackBar(content: Row(
        
       children:<Widget>[
         
         Icon(Icons.favorite,
         color : Colors.red[900],
         size: 40.0,
         ),
         SizedBox(width : 5.0),
         Text('LIKE',
         style : TextStyle(
           fontSize: 40.0,
            color : Colors.greenAccent[100],
            fontWeight: FontWeight.bold,
         )),
       ],),
       duration: Duration(seconds : 1),
       backgroundColor: Colors.white,
     );
     
                    globalKey.currentState.showSnackBar(snackbar);
 
                      print('swipe rigth');
                    }
                  },
                  swipeCompleteCallback:
                      (CardSwipeOrientation orientation, int index) {
                    /// Get orientation & index of swiped card!
                  }
      
     ) ;
  }
}