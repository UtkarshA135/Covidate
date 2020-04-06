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
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.white,
      
    //  appBar: AppBar(
    //   backgroundColor : Colors.pink[800],
    //   title : Text('Sign-In'),
    //   actions :<Widget>[
    //     FlatButton.icon(onPressed: (){
    //       widget.toggleView();
    //     }, icon: Icon(Icons.person), label: Text('Register')),
    //   ],),
     body: 
     SingleChildScrollView(
            child: SafeArea(
              child: Column(children: <Widget>[
           Container(
          // decoration: BoxDecoration(
           
          //   gradient : LinearGradient(colors: [Colors.orange[800],Colors.red[800]],
          //    begin : Alignment.topCenter,
          //   end : Alignment.bottomCenter,
          //   stops: [0.2,0.4])
          // ),
          color: Colors.white,
          padding: EdgeInsets.symmetric(vertical : 20.0 , horizontal : 40.0),
          child : Form(
            key: _formkey,
             child : Column(
            children: <Widget> [
              SizedBox(height: 30.0),
              // Image(
              //   image: NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRceAIuT--lGZWsawuOnvAqAtnF3qoPK3LAOxm77dzmaFSGr0LA&usqp=CAU'),
              // ),
              SizedBox(height: 40.0),
             TextFormField(
               decoration: InputDecoration(
                            //contentPadding: EdgeInsets.only(right: 20.0),
                            labelText: "Enter Email",
                            labelStyle: TextStyle(
                              color: Colors.pink,
                              //letterSpacing: 2.0,
                            ),
                            prefixIcon: Container(
                              //color: Colors.transparent,
                              height: 60.0,
                              //width: 60.0,
                              child: Icon(Icons.person, color: Colors.pink),
                              // decoration: BoxDecoration(
                              //   color: Colors.white,
                              //   borderRadius: BorderRadius.circular(25.0), 
                              // ),
                              //padding: EdgeInsets.only(right: 10.0),
                            ),
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              borderSide: BorderSide(
                              ),
                            ),
                            //fillColor: Colors.green
                          ),
               validator: (val) => val.isEmpty ? 'Enter an Email':null,
               onChanged: (val)
               {
                setState(() => email = val);
               }),
               

             
             SizedBox(height: 20.0),
             TextFormField(
               decoration: InputDecoration(
                            labelText: "Enter Password",
                            labelStyle: TextStyle(color: Colors.pink),
                            prefixIcon:  Container(
                              //color: Colors.transparent,
                              
                              height: 60.0,
                              child: Icon(Icons.lock , color: Colors.pink),
                              // decoration: BoxDecoration(
                              //   shape: BoxShape.rectangle,
                              //   color: Colors.yellow,
                              //   borderRadius: BorderRadius.circular(25.0), 
                              // ),
                              //padding: EdgeInsets.only(right: 10.0),
                            ),
                            //labelStyle: ,
                            //hoverColor: Colors.yellow,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              borderSide: BorderSide(
                              ),
                            ),
                            //fillColor: Colors.green
                          ),
               validator: (val) => val.length < 6 ? 'Enter a password of atleast 6 characters':null,
               obscureText: true,
               onChanged : (val){
                 setState(() =>
                   password=val
            );

               },
             ),
             SizedBox(height : 20.0),
             RaisedButton (
             shape: RoundedRectangleBorder(
               borderRadius: BorderRadius.circular(20.0),
              ),
              child: Ink(
    decoration: const BoxDecoration(
        gradient: LinearGradient(colors: aquaGradients ),
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
    ),
    child: Container(
        constraints: const BoxConstraints(minWidth: 200.0, minHeight: 38.0), // min sizes for Material buttons
        alignment: Alignment.center,
        child: const Text(
          'LOGIN',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 18.0,
            color: Colors.white,
          ),
        ),
    ),),
            //  child: Text(
            //    'LOGIN',
            //    style: TextStyle(
            //      fontSize: 18.0,
            //      color: Colors.red[300],
            //    ),
            //    ),
              //child: ,
             //colors: aquaGradients,
             padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0) ,
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
             FlatButton(
               
               //hoverColor: Colors.pink,
               child: Text(
                 'Don\'t have an acccount? Register Now',
                 ),
               onPressed: (){
                 widget.toggleView();
               }
               ),
             SizedBox(height : 12.0),
             Text(error,
             style : TextStyle(
               color:  Colors.black,
               fontWeight : FontWeight.bold,
               fontSize : 15.0,

             ),),
            
            ]

         )

          )),
    Stack(
                alignment: Alignment.bottomLeft,
                children: <Widget>[
                  WavyFooter(),
                  CirclePink(),
                  CircleYellow(),
                ],
              ),
        
          
         ]),
       ),
     ));
  }
}

const List<Color> aquaGradients = [
  Color(0xFF5AEAF1),
  Color(0xFF8EF7DA),
];

class WavyFooter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: FooterWaveClipper(),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: aquaGradients,
              begin: Alignment.center,
              end: Alignment.bottomRight),
        ),
        height: MediaQuery.of(context).size.height / 3,
      ),
    );
  }
}

class CirclePink extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(-70.0, 90.0),
      child: Material(
        color: Colors.pink,
        child: Padding(padding: EdgeInsets.all(120)),
        shape: CircleBorder(side: BorderSide(color: Colors.white, width: 15.0)),
      ),
    );
  }
}

class CircleYellow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(0.0, 210.0),
      child: Material(
        color: Colors.yellow,
        child: Padding(padding: EdgeInsets.all(140)),
        shape: CircleBorder(side: BorderSide(color: Colors.white, width: 15.0)),
      ),
    );
  }
}
class FooterWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.moveTo(size.width, 0.0);
    path.lineTo(size.width, size.height);
    path.lineTo(0.0, size.height);
    path.lineTo(0.0, size.height - 60);
    var secondControlPoint = Offset(size.width - (size.width / 6), size.height);
    var secondEndPoint = Offset(size.width, 0.0);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class YellowCircleClipper extends CustomClipper<Rect> {
  @override
  Rect getClip(Size size) {
    return null;
  }

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) => false;
}