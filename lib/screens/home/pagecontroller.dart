import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:covidate/services/auth.dart';
import 'package:provider/provider.dart';
import 'all_users_screen.dart';
import 'profile.dart';
import 'home.dart';
class NavigatoBAR extends StatefulWidget {

  @override
  _PagecontrollerState createState() => _PagecontrollerState();
}

class _PagecontrollerState extends State<NavigatoBAR> {
   int selected_page = 1;
  
  @override
  Widget build(BuildContext context) {
      
  final pageOption = [
 Profile(),
 Home(),
 AllUsersScreen(),

  ];
    return Scaffold(
       body: pageOption[selected_page],
       bottomNavigationBar: FancyBottomNavigation(
         initialSelection: 1,
           tabs: [
        TabData(iconData: Icons.person , title: "Profile"),
        TabData(iconData: Icons.favorite, title: "Cards"),
        TabData(iconData: Icons.chat_bubble, title: "Chat")
    ],
    onTabChangedListener: (index) {
        setState(() {
        selected_page = index;
        });
    },
    circleColor: Color(0xFF5AEAF1),
    inactiveIconColor: Color(0xFF5AEAF1),
       ),

      // bottomNavigationBar: BottomNavigationBar(
      //   currentIndex: selected_page,
      //   type: BottomNavigationBarType.fixed,
       
      //   items: [
      //   BottomNavigationBarItem(icon: Icon(Icons.person), title : Text('Profile'), backgroundColor: Colors.yellowAccent,),
      //   BottomNavigationBarItem(icon: Icon(Icons.favorite), title : Text('Cards'), backgroundColor: Colors.yellowAccent,),
      //   BottomNavigationBarItem(icon: Icon(Icons.chat_bubble), title : Text('Chat'), backgroundColor: Colors.yellowAccent,),
      //   ],
      //   onTap: (index){
      //     setState(()
      //     {
      //      selected_page = index;
      //     });
      //   },
      //                    )
    );
  }
}
