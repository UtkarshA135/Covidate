import 'package:flutter/material.dart';
import 'package:covidate/services/auth.dart';
import 'chat.dart';
import 'profile.dart';
import 'home.dart';
class NavigatoBAR extends StatefulWidget {
  @override
  _PagecontrollerState createState() => _PagecontrollerState();
}

class _PagecontrollerState extends State<NavigatoBAR> {
   int selected_page = 1;

  final pageOption = [
 Profile(),
 Home(),
 Chat()

  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: pageOption[selected_page],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selected_page,
        type: BottomNavigationBarType.fixed,
       
        items: [
        BottomNavigationBarItem(icon: Icon(Icons.person), title : Text('Profile'), backgroundColor: Colors.yellowAccent,),
        BottomNavigationBarItem(icon: Icon(Icons.star), title : Text('Cards'), backgroundColor: Colors.yellowAccent,),
        BottomNavigationBarItem(icon: Icon(Icons.chat_bubble), title : Text('Chat'), backgroundColor: Colors.yellowAccent,),
        ],
        onTap: (index){
          setState(()
          {
           selected_page = index;
          });
        },
                         )
    );
  }
}