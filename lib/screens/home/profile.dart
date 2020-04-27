import 'package:covidate/screens/home/background.dart';
import 'package:covidate/services/database.dart';
import 'package:covidate/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:covidate/models/users.dart';
import 'package:provider/provider.dart';
import 'package:covidate/services/auth.dart';
import 'settings.dart';
import 'package:neumorphic/neumorphic.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
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
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: aquaGradients)
      ),
      // appBar: AppBar(
      //   title : Text('Profile'),
      //   centerTitle: true,
      // ),
      child: Column(

       
        children: <Widget>[
        
       StreamBuilder<UserData>(
         stream: DatabaseService(uid : user.uid).userData,
         builder: (context,snapshot){
           if(snapshot.hasData)
           {
            UserData  userData = snapshot.data;
             print(userData.url);
           return SafeArea(
                        child: Column(
               mainAxisAlignment: MainAxisAlignment.center,
               children: <Widget>[
                 Container(
               height: MediaQuery.of(context).size.height *(1/2),
                   width: MediaQuery.of(context).size.width,
                   decoration: BoxDecoration(
                    gradient: LinearGradient(colors: aquaGradients)
                    ),
                   child: Column(
                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                     children: <Widget>[
                       Container(
                         padding: EdgeInsets.only(top: 30.0, bottom: 20.0, left: 30.0),
                         alignment: Alignment.centerLeft,
                         child: Text('My Profile',
                          style: TextStyle(
                            // color: Colors.white,
                            fontSize: 35.0,
                            fontWeight: FontWeight.w800,
                            fontFamily: 'Lobster',
                            decoration: TextDecoration.overline,
                            
                          ),
                          // textAlign: TextAlign.left,
                         ),
                       ),
                      //  SizedBox(height: 50.0,),
                       Container(
            width: 150,
            height: 150,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: (userData.url!=null)? NetworkImage(userData.url) : AssetImage('assets/images.png'),
                // Image.network(userData.url,fit : BoxFit.fill): Image.asset('assets/image.png',fit:BoxFit.fill),,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.white,
                  blurRadius: 40,
                  offset: Offset(0, 10),
                ),
              ],
            ),),
                // CircleAvatar(

                //   radius: 100,
                //     backgroundColor: Colors.grey[400],
                //     child:  ClipOval(
                      
                //       child : SizedBox(
                //       width : 180,
                //        height : 180,
                      
                //        child:
                //     ),
                //     ),
                  
                //     ),
                  SizedBox(height : 15.0),

                       Text(
                        userData.name+" , "+userData.age.toString(),
                          style: TextStyle(
                            fontSize: 30.0,
                            fontWeight: FontWeight.w500,
                            color: Colors.teal[500],
                            fontFamily: 'Pacifico', 
                            
                          ),
                       ),
                     ],
                   )),
                      
                    SizedBox(height : 20.0),
                    Container(
                      padding: EdgeInsets.symmetric(vertical : 15.0),
                       //height: MediaQuery.of(context).size.height *(2/3),
               decoration: BoxDecoration(
                 color: Colors.white,
                 borderRadius: BorderRadius.only(bottomLeft: Radius.circular(100.0), topRight: Radius.circular(100.0) )
               ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                       children: <Widget>[
                            Column(
                            children: <Widget>[
                              NeuButton(
                                //color: Colors.white,
                                child: Icon(Icons.edit),
                                onPressed: ()=> showSettingpanel(),
                                decoration: NeumorphicDecoration(
                                   shape: BoxShape.circle ,
                                  color: Colors.white
                                 )
                                ),
                                Text('Edit Profile',
                                  style: TextStyle(
                                   fontFamily: 'Lobster',
                                   color: Colors.grey[700],
                                  ),
                          )
                            ],

                         ),
                           Column(
                            children: <Widget>[
                              NeuButton(
                                 onPressed: () async {await _auth.signOut();},
                                child: Icon(Icons.exit_to_app),
                                 decoration: NeumorphicDecoration(
                                   shape: BoxShape.circle ,
                                  color: Colors.white 
                                 ),
                                 ),
                               Text('Log Out',
                                  style: TextStyle(
                                   fontFamily: 'Lobster',
                                   color: Colors.grey[700],
                                  ),
                                 )
                             ],
                           )
                        ],),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, top: 50.0),
                      child: RotateAnimatedTextKit(
                        text: ['Just know that I would die for you', "You're my favorite kind of night","I'm just tryna get you out the friend zone",] ,
                        duration: Duration(seconds: 6),
                        textStyle: TextStyle(
                          fontSize: 20.0,
                          fontFamily: 'Lobster',
                          color: Colors.teal[400],
                          ),
                        ),
                    )
               ]),
           );
         }
         else{
           return Center(child :Loading());
         }
         })
      ],)
    );
      
    
  }
}

