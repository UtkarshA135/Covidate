import 'package:flutter/material.dart';
import 'package:covidate/services/auth.dart';
class Home extends StatelessWidget {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[200],
      appBar: AppBar(
        title : Text('Home'),
        backgroundColor : Colors.pink[800],
        actions: <Widget>[
          FlatButton.icon(onPressed: () async {
            await _auth.signOut();
          }, icon: Icon(Icons.person), label: Text('Log out'))
        ],
        
      ),
      
    );
  }
}