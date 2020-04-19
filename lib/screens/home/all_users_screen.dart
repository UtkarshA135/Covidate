import 'dart:async';
import 'dart:io';
import 'package:provider/provider.dart';
import 'package:covidate/models/users.dart';
import 'chatscreen.dart';
import 'package:covidate/models/cards.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


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
          title: Text("All Users"),
         
        ),
        body: usersList != null
            ? Container(
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
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage: usersList[index].data['url']!= null ?
                            NetworkImage(usersList[index].data['url']): AssetImage('assets/popo.jpg')
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
                    );}
                  }),
                ),
              )
            : Center(
                child: CircularProgressIndicator(),
              ));
  }
}