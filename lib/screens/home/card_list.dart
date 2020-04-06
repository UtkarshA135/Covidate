import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covidate/screens/authenticate/register.dart';
import 'package:covidate/shared/loading.dart';
import 'package:flutter/material.dart';
import 'match.dart';
import 'package:provider/provider.dart';
import 'package:covidate/models/cards.dart';
import 'custom_card.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: new MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  Animation cardAnimation, delayedCardAnimation, fabButtonanim, infoAnimation;
  AnimationController controller;
    List<Positioned> cardList  ;
final globalKey = GlobalKey<ScaffoldState>();



  void _removeCard(index) {
    setState(() {
      cardList.removeAt(index);
    });
  }
  void dispaly(isLiked)
  { if(isLiked == true)
 {
   
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
 
   }
   else{
     
       final snackbar = SnackBar(content: Row(
       children:<Widget>[
         
         Icon(Icons.not_interested,
         color : Colors.red[900],
         size: 40.0,
         ),
         SizedBox(width : 5.0),
         Text('NOPE',
         style : TextStyle(
            color : Colors.red[100],
            fontSize: 40.0,
            fontWeight: FontWeight.bold,
         )),
       ],),
       duration: Duration(seconds : 1),
       backgroundColor: Colors.lightBlue,
     );
                    globalKey.currentState.showSnackBar(snackbar);
 

   }
  }

  @override
  void initState() {

    super.initState();
    controller =
        AnimationController(duration: Duration(seconds: 2), vsync: this);

    cardAnimation = Tween(begin: 0.0, end: -0.025).animate(
        CurvedAnimation(curve: Curves.fastOutSlowIn, parent: controller));

    delayedCardAnimation = Tween(begin: 0.0, end: -0.05).animate(
        CurvedAnimation(
            curve: Interval(0.5, 1.0, curve: Curves.fastOutSlowIn),
            parent: controller));

    fabButtonanim = Tween(begin: 1.0, end: -0.0008).animate(CurvedAnimation(
        curve: Interval(0.8, 1.0, curve: Curves.fastOutSlowIn),
        parent: controller));

    infoAnimation = Tween(begin: 0.0, end: 0.025).animate(CurvedAnimation(
        curve: Interval(0.7, 1.0, curve: Curves.fastOutSlowIn),
        parent: controller));

                    
  }

  @override
  Widget build(BuildContext context) {
         
    final devHeight = MediaQuery.of(context).size.height;
    controller.forward();
    return new AnimatedBuilder(
        animation: controller,
        
        builder: (BuildContext context, Widget child) {
          return Scaffold(
            
            backgroundColor: Colors.orange[100],
             key: globalKey,
            
         
            body:ConstrainedBox(
                  constraints: BoxConstraints(minWidth: 200, minHeight: 500),
                  child :
              Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.fromLTRB(20.0, 40.0, 20.0, 40.0),
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
                
                    return new Stack(
                    
                       children:
                          snapshot.data.documents
                      .map((DocumentSnapshot document) {
                      //  cardList.add(document['name']);
                   
                          return (Positioned(child: 
                                
                           Draggable(
                                onDragEnd: (drag){
                             
                              document.reference.delete();
  // Show a red background as the item is swiped away.
  
                               
                              /* if(drag.offset.direction > 1){
                                    isLiked = false;
                                    print('swipeleft');
                                       } else {
                                      isLiked = true;
                                      print('swipeRight');
            
                               }
                                 dispaly(isLiked);*/
             
                                   },
                                   childWhenDragging: Container(),
                                 feedback:  Card(
               
                  
                               child : Container(
                                width: 300.0,
                                 height: 400.0,
                          
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              image: DecorationImage(
                                  image: NetworkImage(document['url']),
                                  fit: BoxFit.fitWidth)),
                       child: Column(children: <Widget>[
                         
                                   Text(document['name'],
                                   style : TextStyle(
                                    // fontFamily: 'IndieFlower',
                                      fontWeight : FontWeight.bold,
                                      color:  Colors.black,
                                    )
                                   ),
                       ],),),),
                   
                    child: Card(
                          child : Column(children: <Widget>[
                            Container(
                          width: 700.0,
                          height: 400.0,
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
                        
                          ],),
                    ),
                    ),
                   
                    )
                        
                    );
                        
                    }
                      
                    
                        
                    ).toList(),
                    );
                    }
              }),
                     ),
                       Expanded(
          child: Align(
            alignment: FractionalOffset.bottomCenter,
                 child : Container(
                  transform: Matrix4.translationValues(0.0, fabButtonanim.value * devHeight, 0.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      FloatingActionButton(
                        elevation: 5.0,
                        onPressed: () {},
                        child: Icon(Icons.close, color: Colors.black),
                        backgroundColor: Colors.white,
                      ),
                      Container(
                        height: 70.0,
                        width: 70.0,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(35.0),
                          border: Border.all(
                              color: Colors.transparent,
                              style: BorderStyle.solid,
                              width: 2.0),
                        ),
                        child: Container(
                          child: Center(
                            child: IconButton(
                              
                              icon: Icon(Icons.chat),
                              color: Colors.lightBlueAccent[300],
                              onPressed: () {},
                            ),
                          ),
                        ),
                      ),
                      FloatingActionButton(
                        elevation: 5.0,
                        onPressed: () {},
                        child: Icon(Icons.favorite, color: Colors.pink),
                        backgroundColor: Colors.white,
                      )
                    ],
                  ),
                )))
              ],
            ),
           ) ); 
        });
  }
    
   
 
    }
    