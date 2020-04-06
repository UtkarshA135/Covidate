import 'package:covidate/services/database.dart';
import 'package:covidate/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:covidate/models/users.dart';
import 'package:provider/provider.dart';
import 'package:covidate/services/auth.dart';
import 'settings.dart';
class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
    final AuthService _auth = AuthService();
  @override
 
  Widget build(BuildContext context) {
     void showSettingpanel()
  {
    showModalBottomSheet(context: context, builder: (context){
        return Container(
          padding : EdgeInsets.symmetric(vertical : 20.0 , horizontal : 60.0),
          child: Settings(),

        );
    }
    );
  }
    final user = Provider.of<User>(context);
    return Scaffold(
      appBar: AppBar(
        title : Text('Profile'),
        centerTitle: true,
      ),
      body: Column(
       
        children: <Widget>[
        
       StreamBuilder<UserData>(
         stream: DatabaseService(uid : user.uid).userData,
         builder: (context,snapshot){
           if(snapshot.hasData)
           {
            UserData  userData = snapshot.data;
             print(userData.url);
           return Column(
             mainAxisAlignment: MainAxisAlignment.center,
             children: <Widget>[
              CircleAvatar(

                radius: 100,
                  backgroundColor: Colors.grey[400],
                  child:  ClipOval(
                    
                    child : SizedBox(
                    width : 180,
                     height : 180,
                    
                     child:(userData.url!=null)? Image.network(userData.url,fit : BoxFit.fill): Image.asset('assets/popo.jpg',fit:BoxFit.fill),
                  ),
                  ),
                
                  ),
                SizedBox(height : 15.0),
                    Row(
                     mainAxisAlignment: MainAxisAlignment.center,
                    children:<Widget>[
                  Text(userData.name+","),
                  
                  Text(userData.age.toString()),
                    ]
                  ),
                  SizedBox(height : 20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      FlatButton.icon(onPressed: ()=> showSettingpanel(), icon: Icon(Icons.settings), label: Text('Edit Profile')),
                       FlatButton.icon(onPressed: () async {
              await _auth.signOut();
            }, icon: Icon(Icons.person), label: Text('Log out'))
                    ],)
             ]);
         }
         else{
           return Loading();
         }
         })
      ],)
    );
      
    
  }
}