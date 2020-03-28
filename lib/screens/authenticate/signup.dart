import 'package:covidate/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:covidate/shared/loading.dart';
class SignIn extends StatefulWidget {
    final Function toggleView;
 SignIn({this.toggleView});
  @override
  _SignUpState createState() => _SignUpState();
}

String email ='';
 String password = '';
  String error ='';
  
class _SignUpState extends State<SignIn> {
  final AuthService _auth = AuthService();
   final _formkey = GlobalKey<FormState>();
   bool loading = false;
  @override
  Widget build(BuildContext context) {
    
    return loading ? Loading() :Scaffold(
     
     appBar: AppBar(
      backgroundColor : Colors.pink[800],
      title : Text('Sign-In'),
      actions :<Widget>[
        FlatButton.icon(onPressed: (){
          widget.toggleView();
        }, icon: Icon(Icons.person), label: Text('Register')),
      ],),
    body: Container(
      decoration: BoxDecoration(
       
        gradient : LinearGradient(colors: [Colors.orange[800],Colors.red[800]],
         begin : Alignment.topCenter,
        end : Alignment.bottomCenter,
        stops: [0.2,0.4])
      ),
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
         RaisedButton(child: Text('Sign in'),
         color: Colors.cyan,
         onPressed:() async {
              if(_formkey.currentState.validate())
          { setState(() {
            loading =true;
          });
             dynamic result = await _auth.signInwithEmailandPassword(email, password);
         
          if(result == null)
          {
           
            setState(() {
               loading = false;
              error = 'Could not sign-in with those credentials';
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