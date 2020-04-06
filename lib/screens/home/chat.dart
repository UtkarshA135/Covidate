//import 'package:covidate/screens/home/profile.dart';
import 'package:flutter/material.dart';
import 'custom_profile.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';
//import 'package:tinder_card/tinder_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covidate/shared/loading.dart';


class Chat extends StatefulWidget {
  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  @override
  Widget build(BuildContext context) {

  //Use this to trigger swap.
      CardController controller;
      return new Scaffold(
      body: new Center(
          child: Container(
              height: MediaQuery.of(context).size.height * 0.8,
              child: new TinderSwapCard(
                  orientation: AmassOrientation.BOTTOM,
                  totalNum: 3,
                  stackNum: 3,
                  swipeEdge: 4.0,
                  maxWidth: MediaQuery.of(context).size.width * 0.9,
                  maxHeight: MediaQuery.of(context).size.width * 0.9,
                  minWidth: MediaQuery.of(context).size.width * 0.8,
                  minHeight: MediaQuery.of(context).size.width * 0.8,
                  cardBuilder: (context, index) => Card(
                                           child :StreamBuilder<QuerySnapshot>(
            stream: Firestore.instance.collection('users')
              .snapshots(),
              
            builder: (BuildContext context, 
              AsyncSnapshot<QuerySnapshot> snapshot) {
                
                if (snapshot.hasError)
                  return new Text('Error: ${snapshot.error}');
                  /*if((snapshot.hasData)==null)*/
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return new Center(child :Loading());
                  default:
                        snapshot.data.documents
                      .map((DocumentSnapshot document) {
                        if(!(document.exists)) return Container();
                      return   Column(children: <Widget>[
                            Container(
                          width: 700.0,
                          height: 300.0,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              image: DecorationImage(
                                  image: NetworkImage(document['url']),
                                  fit: BoxFit.cover)),
                                   child: Column(children: <Widget>[
                         
                                    Expanded(child:   Align(  alignment: FractionalOffset.bottomCenter, child:  Text(document['name'],
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
                          }).toList();
                          }},),
                    ),
                  cardController: controller = CardController(),
                  swipeUpdateCallback:
                      (DragUpdateDetails details, Alignment align) {
                    /// Get swiping card's alignment
                    if (align.x < 0) {
                      //Card is LEFT swiping
                    } else if (align.x > 0) {
                      //Card is RIGHT swiping
                    }
                  },
                  swipeCompleteCallback:
                      (CardSwipeOrientation orientation, int index) {
                    /// Get orientation & index of swiped card!
                  }))),
    );
  }
   List<CustomProfile> welcomeImages = [
     new CustomProfile(
       photos :'assets/virat.jpg',
       name : 'Utkarsh'
       
     ),
 new CustomProfile(
       photos :'assets/Rohit.jpg',
       name : 'shruti'
       
     ),
      new CustomProfile(
       photos :'assets/popo.jpg',
       name : 'Sinchana'
       
     ),

];
}