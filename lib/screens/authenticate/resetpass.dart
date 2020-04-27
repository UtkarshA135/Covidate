import 'package:covidate/screens/home/background.dart';
import 'package:covidate/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:covidate/shared/loading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class ResetPass extends StatefulWidget {
    final Function toggleView;
 ResetPass({this.toggleView});
  @override
  _ResetPassState createState() => _ResetPassState();
}

String email ='';
//  String password = '';
  String error ='';
  
class _ResetPassState extends State<ResetPass> {
  final AuthService _auth = AuthService();
   final _formkey = GlobalKey<FormState>();
   bool loading = false;
 
 
  @override
  Widget build(BuildContext context) {
    
    return loading ? Loading() :Scaffold(
     
    body: SingleChildScrollView(
          child: Container(
        color: Colors.white,
        // padding: EdgeInsets.fromLTRB(20.0, 50.0, 10.0 , 5.0),
        padding: EdgeInsets.only(top:50.0),
        child : Column(
          children: <Widget>[
          
            Padding(
             padding: EdgeInsets.fromLTRB(20.0, 50.0, 10.0 , 5.0),
              child: Form(
                key: _formkey,
                 child : Column(
                children: <Widget> [
                  Container(
                    child: Text("We will send a link to your mail, please reset your password there",
                    style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.pink,
                    // fontFamily: 'Lobster',
                    // fontSize: ScreenUtil().setSp(100.0),
                  ),
                    )
                  ),
                  SizedBox(height: 40.0),
                  Text('Reset Password',
                  style: TextStyle(
                    fontSize: 40.0,
                    fontFamily: 'Lobster',
                    decoration: TextDecoration.overline,
                    // fontSize: ScreenUtil().setSp(100.0),
                  ),
                  ),
                  SizedBox(height: 100.0),
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
                   SizedBox(height: 40.0),

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
                     child: Text('Reset Password' , style: TextStyle(color: Colors.white), textAlign: TextAlign.center,),
                   ), 
                 ),
                 onTap:() async {
                        if(_formkey.currentState.validate())
                    { setState(() {
                      loading =true;
                    });
                      //  dynamic result =
                        await _auth.sendPasswordResetEmail(email);
                        // _warning = "A password reset link has been sent to $_email";
                      setState((){
                        
                        Navigator.pop(context);

                      });
                    // if(result == null)
                    // {
                     
                    //   setState(() {
                    //      loading = false;
                    //     error = 'Could not send mail';
                    //   });
                    // }
                    
                    }
                   },),
                  FlatButton(
                    child: Text('Return Back to Sign In'),
                    onPressed: () => Navigator.pop(context),
                  )
                ]
                )
              )
              )
            ]
          )
        )
      )
    );
  }
}         
