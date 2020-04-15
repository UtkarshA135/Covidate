import 'package:flutter/material.dart';
import 'package:covidate/services/auth.dart';
import 'chat.dart';
import 'profile.dart';
import 'card_list.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:covidate/services/database.dart';
import 'package:covidate/models/cards.dart';
import 'cardlist.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
 
   final globalKey = GlobalKey<ScaffoldState>();
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Cards>>.value(
           value : DatabaseService().cards,
          child: Scaffold(
             key: globalKey,
            
        backgroundColor: Colors.white,
        appBar: AppBar(
          title : Text('Home'),
          backgroundColor : Colors.pink[800],
          actions: <Widget>[
           
          ],
          
        ),
       body: CardLiist(),
                     ),
    );
                   
                 }
}
               
 
