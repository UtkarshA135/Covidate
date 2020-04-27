import 'package:covidate/screens/authenticate/resetpass.dart';
import 'package:covidate/screens/home/background.dart';
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
    bool _isvisible= true;
 void toggleVisibility(){
   setState(() {
     _isvisible = !_isvisible;
   });
 }
  @override
  Widget build(BuildContext context) {
    
    return loading ? Loading() :Scaffold(
     
    //  appBar: AppBar(
    //   backgroundColor : Colors.pink[800],
    //   title : Text('Sign-In'),
    //   actions :<Widget>[
    //     FlatButton.icon(onPressed: (){
    //       widget.toggleView();
    //     }, icon: Icon(Icons.person), label: Text('Register')),
    //   ],),
    body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
               Image.asset(
             'assets/covidate2.png',
              // width: MediaQuery.of(context).size.width*1.0,
              // scale: 4.0,
            ),
              Padding(
        // color: Colors.white,
        padding: EdgeInsets.fromLTRB(20.0, 150.0, 10.0 , 5.0),
        child : Form(
              key: _formkey,
               child : Column(
              children: <Widget> [
               
                SizedBox(height: 20.0),
               TextFormField(
                 decoration: InputDecoration(
                   labelText: 'Enter Email',
                   labelStyle: TextStyle(
                     color: Colors.pink
                   ),
                   prefixIcon: Icon(Icons.person, color: Colors.pink,),
                   border: OutlineInputBorder(
                     borderRadius: BorderRadius.circular(50.0)
                   )
                 ),
                 validator: (val) => val.isEmpty ? 'Enter an Email':null,
                 onChanged: (val)
                 {
                  setState(() => email = val);
                 }),
                 

               
               SizedBox(height: 20.0),
               TextFormField(
                 decoration: InputDecoration(
                   labelText: 'Enter Password',
                   prefixIcon: Icon(Icons.lock, color: Colors.pink ),
                   labelStyle: TextStyle(
                     color: Colors.pink
                   ),
                   border: OutlineInputBorder(
                     borderRadius: BorderRadius.circular(50.0)
                   ),
                    suffixIcon: IconButton(
                 onPressed: toggleVisibility,
                 icon: Icon(!_isvisible? Icons.visibility: Icons.visibility_off))
                  ),
                //  ),
                 validator: (val) => val.length < 6 ? 'Enter a password of atleast 6 characters':null,
                 obscureText: _isvisible,
                 onChanged : (val){
                   setState(() =>
                     password=val
              );

                 },
               ),
               SizedBox(height : 20.0),
               GestureDetector(
                 child: Container(
                   width: MediaQuery.of(context).size.width*0.8,
                   
                   alignment: Alignment.center,
                 decoration: BoxDecoration(
                   gradient: LinearGradient(colors: aquaGradients),
                   borderRadius: BorderRadius.circular(50.0)
                 ),
                 child: Padding(
                   padding: const EdgeInsets.all(16.0),
                   child: Text('Login' , style: TextStyle(color: Colors.white), textAlign: TextAlign.center,),
                 ), 
               ),
                    
                 
                 onTap:() async {
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
                FlatButton(
                 child: Text("Forgot Password?"),
                   onPressed: (){  Navigator.push(context, MaterialPageRoute(builder: (context)=> ResetPass() ));
                   }
                 ),
               FlatButton(
                 child: Text("Don't have an account? Register Now"),
                 onPressed: (){
                widget.toggleView();
              } ,
               ),
               SizedBox(height : 12.0),
               Text(error,
               style : TextStyle(
                 color:  Colors.black,
                 fontWeight : FontWeight.bold,
                 fontSize : 15.0,

               ),),

                 Stack(
                  alignment: Alignment.bottomLeft,
                  children: <Widget>[
                    WavyFooter(),
                    CirclePink(),
                    CircleYellow(),
                  ],
                )
              ]

        ),

        ),),
            ],
          ),
    )
    
   
      
    );
  }
}
