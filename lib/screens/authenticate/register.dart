import 'package:covidate/screens/authenticate/signup.dart';
import 'package:covidate/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:covidate/services/auth.dart';
class Register extends StatefulWidget {
  final Function toggleView;
  Register({this.toggleView});
  @override
  _RegisterState createState() => _RegisterState();
}

String email ='';
 String password = '';
 String error ='';
 bool loading = false;
class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
   return loading ? Loading() : Scaffold(

    backgroundColor: Colors.pink[200],
   
 appBar: AppBar(
      backgroundColor : Colors.pink[800],
      title : Text('Sign-Up'),
      actions :<Widget>[
        FlatButton.icon(onPressed: (){
          widget.toggleView();
        }, icon: Icon(Icons.person), label: Text('Sign-In')),
      ]

    ),
    body: Container(
      padding: EdgeInsets.symmetric(vertical : 20.0 , horizontal : 50.0),
      child : Form(
        key: _formkey,
         child : Column(
        children: <Widget> [
          SizedBox(height: 20.0),
         TextFormField(
           validator: (val) => val.isEmpty ? 'Enter an Email':null,
           onChanged: (val)
           {
            setState(() => email = val);
           }),
           

         
         SizedBox(height: 20.0),
         TextFormField(
           validator: (val) => val.length < 6 ? 'Enter a password of atleast 6 characters':null,
           obscureText: true,
           onChanged : (val){
             setState(() =>
               password=val
        );

           },
         ),
         SizedBox(height : 20.0),
         RaisedButton(child: Text('Sign up'),
         color: Colors.cyan,
         onPressed:() async {
           if(_formkey.currentState.validate())
          { setState(() {
            loading =true;
          });
             dynamic result = await _auth.registerwithEmailandPassword(email, password);
             loading = true;
          if(result == null)
          {
            
            setState(() {
               loading = false;
              error = 'Please supply a valid email !!';
            });
          }
          
          }

         },),
         SizedBox(height : 12.0),
         Text(error,
         style : TextStyle(
           color:  Colors.black,
           fontWeight : FontWeight.bold,
           fontSize : 15.0,

         ),)
        ]

      )

      ))
    
   
      
    );
  }
}