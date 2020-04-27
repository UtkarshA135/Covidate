import 'dart:async';
import 'dart:io';
import 'package:provider/provider.dart';
import 'package:covidate/models/users.dart';
import 'chatscreen.dart';
import 'package:covidate/models/cards.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neumorphic/neumorphic.dart';


class AllUsersScreen extends StatefulWidget {
  _AllUsersScreenState createState() => _AllUsersScreenState();
}

class _AllUsersScreenState extends State<AllUsersScreen> {

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  StreamSubscription<QuerySnapshot> _subscription;
  List<DocumentSnapshot> usersList;
  final CollectionReference _collectionReference =
      Firestore.instance.collection("matches");
  final FirebaseAuth _auth = FirebaseAuth.instance;
 inputData() async  {
    final FirebaseUser user =  await _auth.currentUser();
    final uid = user.uid;
      _subscription = _collectionReference.document(uid).collection('match').snapshots().listen((datasnapshot) {
      setState(() {
        usersList = datasnapshot.documents;
        print("Users List ${usersList.length}");
      });
    });
   
    // here you write the codes to input the data into firestore
  }
  @override
  void initState()  {
    super.initState();
      inputData();

  
  }

  @override
  void dispose() {
    super.dispose();
    _subscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
        //final users = Provider.of<List<Cards>>(context) ;
 
    final String currentuser = user?.uid;
     
    
    return Scaffold(
        appBar: AppBar(
          // title: Text("All Users"),
          title: Text(" Chat with Match",
            style: TextStyle(
              fontFamily: 'Lobster',
              color: Colors.black,
              fontSize: ScreenUtil().setSp(70.0),
            ),
          ),
           centerTitle: true,
          backgroundColor:  Color(0xFF5AEAF1),
        ),
        body: usersList != null
             ? (usersList.length==0?
              Container(
             color: Color(0xEDD8E2),
              // color: Color(0xfadcf8),
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Sorry!',
                    style: TextStyle(
                      color: Colors.redAccent,
                      fontSize: ScreenUtil().setSp(100.0),
                      fontFamily: 'Lobster'
                    )
                  ),
                  SizedBox(height: 20.0),
                  Image.network('https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQge3zH1vQU2BtGQLBTEeyYY7oY15AXTufAT1EbnKZqbooIfsjI&usqp=CAU'),
                  SizedBox(height: 30.0),
                  Text('No matches yet :(',
                  style: TextStyle(
                    fontSize: ScreenUtil().setSp(60.0),
                    letterSpacing: 1.1,
                    color: Colors.black45,
                  )
                  )
                ],
              ),
            )
           : Container(
                child: ListView.builder(
                  itemCount: usersList.length,
                  itemBuilder: ((context, index) {
                    
                    if(currentuser == usersList[index].data['ownerId'])
                    {
                      return Container();
                    }
                else
                    {
                      print(usersList[index].data['name']);
                      print(usersList[index].data['ownerId']);
                     return NeuCard(
                      margin: EdgeInsets.all(10.0),
                      padding: EdgeInsets.all(5.0),
                      curveType: CurveType.concave,
                       bevel: 12,
                       decoration: NeumorphicDecoration(
                       color: Colors.white,
                         borderRadius: BorderRadius.circular(8)
                       ),
                          child: ListTile(
                        leading: CircleAvatar(
                          backgroundImage: usersList[index].data['url']!= null ?
                              NetworkImage(usersList[index].data['url']): AssetImage('assets/images.png')
                      ),
                      title:usersList[index].data['name'] != null ?Text(usersList[index].data['name'],
                       style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          )): Text('user',
                           style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          )),
                         
                      subtitle: usersList[index].data['bio']!=null ?Text(usersList[index].data['bio'],
                          style: TextStyle(
                            color: Colors.grey,
                          )): Text('Bio'),
                      onTap: (() {
                        Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (context) => ChatScreen(
                                    name: usersList[index].data['name'],
                                    photoUrl: usersList[index].data['url'],
                                    receiverUid:usersList[index].data[
                                        'ownerId'])));
                      }),
                    
                          ),
                          );
                     }} )
                )
                          ))
                      : Center(
                child: CircularProgressIndicator(),
              ));
  }
}
