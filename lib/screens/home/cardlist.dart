import 'dart:async';



import 'package:edge_alert/edge_alert.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'card_tile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covidate/models/cards.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';
import 'package:covidate/models/users.dart';
class CardLiist extends StatefulWidget {
  @override
  _CardLiistState createState() => _CardLiistState();
}
final FirebaseAuth _auth = FirebaseAuth.instance;
Future<FirebaseUser> _curreent =  _auth.currentUser();
class _CardLiistState extends State<CardLiist> {
  Map likes;
  bool isLiked;
 bool likerother = true;
  bool likemine;
  bool showLike = true;
  
final CollectionReference userCollection = Firestore.instance.collection('users');
 CollectionReference matchRef= Firestore.instance.collection('matches');

  
  final globalKey = GlobalKey<ScaffoldState>();
   void _colorfullAlert(bool match1) {
    
   
        EdgeAlert.show(context,
        title: 'Loved it',
        description: 'Nice Choice',
        icon: Icons.favorite,
        gravity: EdgeAlert.BOTTOM,
        backgroundColor: Colors.pink[300]);
        

        
  }
    void _colorfullAlert3() {
           EdgeAlert.show(context,
        title: 'New Match',
        description: 'You guys are gonna rock it',
        icon: Icons.nature_people,
        gravity: EdgeAlert.TOP,
        backgroundColor: Colors.purple[300]);

    }
 void _colorfullAlert2() {
    EdgeAlert.show(context,
        title: 'Not interested',
        description: 'No problem !! We have got a lot for you',
        icon: Icons.not_interested,
        gravity: EdgeAlert.BOTTOM,
        backgroundColor: Colors.green[300]);
  }
  @override
  Widget build(BuildContext context) {
     bool match = false;
   
    final users = Provider.of<List<Cards>>(context) ;
    final user = Provider.of<User>(context);
 
    final String currentuser = user?.uid;
    // isLiked = (likes[currentuser]==true);
     String ownerId = null ;
    
      matchRef.document(currentuser).setData({});

    CardController controller;
     return users!=null ?
    TinderSwapCard(
          
                  orientation: AmassOrientation.BOTTOM,
                  totalNum: users.length,
                  stackNum: 8,
                  swipeEdge: 4.0,
                  maxWidth: MediaQuery.of(context).size.width * 0.9,
                  maxHeight: MediaQuery.of(context).size.width * 0.9,
                  minWidth: MediaQuery.of(context).size.width * 0.8,
                  minHeight: MediaQuery.of(context).size.width * 0.8,
                  cardBuilder: (context,index){
                   ownerId = users[index].ownerid;
                     if(currentuser == ownerId)
                     return Container();
                     else
                     { 
                      
                   //  print(likemine);
                   likerother = users[index].mylikes[currentuser];
                  likemine = users[index].likes[currentuser];
                  print(likemine);
                  print(likerother);
                           matchRef.document(currentuser).collection('match');
                    if(likemine == true && likerother == true)
                       {
                       
                    
                        match = true;

                      matchRef.document(currentuser).collection('match').document(ownerId).setData({
                        'name' : users[index].name,
                        'age' : users[index].age,
                        'bio': users[index].bio,
                        'url': users[index].url,
                        'ownerId': users[index].ownerid
                      });
                      matchRef.document(ownerId).collection('match').document(currentuser).setData({});
                      // _colorfullAlert3();
                     // matchRef.document(ownerId).collection('match').document(currentuser).setData({});

                       }
                    return  CardTile(card : users[index], showlike: showLike,);
                  }},
              cardController: controller = CardController(),
              
                  swipeUpdateCallback:
                      (DragUpdateDetails details, Alignment align) {
                    /// Get swiping card's alignment
                    if (align.x < 0) {
                      //Card is LEFT swiping
            
                      _colorfullAlert2();
                       
                        userCollection.document(ownerId).updateData({'likes.$currentuser':false});
                        userCollection.document(currentuser).updateData({'mylikes.$ownerId' : false});
                        matchRef.document(currentuser).collection('match').document(ownerId).get().then((doc){
                          if(doc.exists)
                          doc.reference.delete();
                          //_colorfullAlert3();
                        });
                         matchRef.document(ownerId).collection('match').document(currentuser).get().then((doc){
                          if(doc.exists)
                          doc.reference.delete();
                        });
                    
                         setState(() {
                           isLiked = false;
                           match = false;
                           likes[currentuser] = false;
                           showLike = false;
                         });
                       
                          
                    } else if (align.x > 0) {
                      //Card is RIGHT swiping
                       userCollection.document(ownerId).updateData({'likes.$currentuser':true});
                       userCollection.document(currentuser).updateData({'mylikes.$ownerId' : true});
                           matchRef.document(currentuser).collection('match').document(ownerId).get().then((doc){
                          if(doc.exists)
                          _colorfullAlert3();
                          else
                            _colorfullAlert(match);
                           });
                        
                     
                        
                      // print(likerother);
                     
                         setState(() {
                           isLiked = true;
                            match = true;
                           likes[currentuser] = true;
                           showLike = true;
                         });
                  
               
                    }
                   
                 /*   Timer(Duration(milliseconds : 500),(){
                           showLike = !showLike;
                    });
                      showLike ? Icon(Icons.favorite,size :80.0 ,color : Colors.red): Icon(Icons.not_interested,size :80.0 ,color : Colors.red);*/
                       
                         
                    
                    
                  },
                  swipeCompleteCallback:
                      (CardSwipeOrientation orientation, int index) {
                    /// Get orientation & index of swiped card!
                  }
                  
     ) : Center(
       child : CircularProgressIndicator()
     );
  }
}