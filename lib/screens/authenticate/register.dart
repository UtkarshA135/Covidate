

import 'dart:io';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:covidate/screens/authenticate/signup.dart';
import 'package:covidate/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:covidate/services/auth.dart';
import 'signup.dart';
//import '../../services/auth.dart';
class Register extends StatefulWidget {
  final Function toggleView;
  Register({this.toggleView});
  @override
  _RegisterState createState() => _RegisterState();
}

String email ='';
 String password = '';
 String name = ' ';
int  age = 18 ;
 String gender;
 String bio = '';
 String error ='';
 bool loading = false;
 String url;
class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
//  final ImageUploadGet _imageup = ImageUploadGet();
  final _formkey = GlobalKey<FormState>();
  final List<String> genders = ['MALE' , 'FEMALE' ,'OTHERS'];
 File _image;

  @override
  Widget build(BuildContext context) {

 

Future  uploadImage () async{
final StorageReference postImgref = FirebaseStorage.instance.ref().child('Post Images');
var timeKey = new DateTime.now();
final StorageUploadTask uploadTask = postImgref.child(timeKey.toString()+'.jpg').putFile(_image);
var imgurl = await(await uploadTask.onComplete).ref.getDownloadURL();
url = imgurl.toString();
print(url);
 }
 Future  getImage() async {
 var image = await ImagePicker.pickImage( source : ImageSource.gallery);
   setState((){
    
    _image = image;
    
 });
 
}
   return loading ? Loading() :  GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child : Scaffold(

    backgroundColor: Colors.white,
   
//  appBar: AppBar(
//       backgroundColor : Colors.pink[800],
//       title : Text('Sign-Up'),
//       actions :<Widget>[
//         FlatButton.icon(onPressed: (){
//           widget.toggleView();
//         }, icon: Icon(Icons.person), label: Text('Sign-In')),
//       ]

//     ),
    
    body:
     SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxHeight: 1250.0),            
          child: Form(
    key: _formkey,
          child : Column(
    children: <Widget> [
    
                   SizedBox(height: 20.0),
            Column(
             crossAxisAlignment: CrossAxisAlignment.center,
             children : <Widget>[
          Align(
                   alignment : Alignment.center,
                   child : CircleAvatar(
          radius: 100,
          backgroundColor: Colors.grey[600],
          child:  ClipOval(
                  
                  child : SizedBox(
                  width : 180,
          height : 180,
          
          child:(_image!=null)? Image.file( _image,fit : BoxFit.fill): Image.network('https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQoxOotTL-NqVtttTdTzaW4cuX1VlBwCe_WNWwZLgFSxUfRZ_qH&usqp=CAU',fit:BoxFit.fill,),
          ),
          ),
                   
          ),
          ),
           Row(
         mainAxisAlignment: MainAxisAlignment.center,
         children: <Widget>[
             FlatButton.icon(label:Text('Choose Image', style: TextStyle(color: Colors.pink)) , icon: Icon( Icons.camera, size: 30.0, color: Colors.black,  ), onPressed: (){
           getImage();
           //dynamic getim = _imageup.getImage();
           //getim();
                  }),
                  FlatButton.icon(label: Text('Upload Image', style: TextStyle(color: Colors.pink)), icon : Icon(Icons.file_upload, color: Colors.black),onPressed :() async { await uploadImage();} ),
         ],
           ),
          
          
           ],),
            TextFormField(
         decoration: InputDecoration(
                   labelText: "Enter Email",
                   labelStyle: TextStyle(
          color: Colors.pink
                   ),
                   prefixIcon: Icon(Icons.person,color: Colors.black ),
                   fillColor: Colors.white,
                   border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
          borderSide: BorderSide(
          ),
                   ),
           ),
         validator: (val) => val.isEmpty ? 'Enter an Email':null,
         onChanged: (val)
         {
            setState(() => email = val);
         }),
            SizedBox(height: 20.0),
            TextFormField(
         decoration: InputDecoration(
                   //contentPadding: EdgeInsets.only(right: 20.0),
                   labelText: "Enter Password",
                   labelStyle: TextStyle(
          color: Colors.pink,
          //letterSpacing: 2.0,
                   ),
                   prefixIcon: Icon(Icons.lock ,color: Colors.black),
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
            TextFormField(
                   decoration: InputDecoration(
                   //contentPadding: EdgeInsets.only(right: 20.0),
                   labelText: "Enter Name",
                   labelStyle: TextStyle(
             color: Colors.pink,
             //letterSpacing: 2.0,
                   ),
                   fillColor: Colors.white,
                   border: OutlineInputBorder(
             borderRadius: BorderRadius.circular(25.0),
             borderSide: BorderSide(
             ),
                   ),
                   //fillColor: Colors.green
           ), 
            validator: (val) => val.isEmpty ? 'Enter a valid name':null,
            onChanged: (val)
            { 
                   setState(() => name = val);
            }),
            SizedBox(height: 20.0),
            Row(
              
         children : <Widget>[
           SizedBox(width: 20.0),
             Text('AGE',
             style: TextStyle(
               color: Colors.pink,
               fontSize: 18.0,
             ),),
             SizedBox(width : 5.0),
                   Slider(
             value: ( age ?? 18.0).toDouble(),
             activeColor: Colors.black,
             min : 18.0,
             max : 30.0,
             divisions: 12,
         onChanged: (val)
         {
            setState(() => age = val.round());
         }
         ),
         SizedBox(width : 5.0),
         
         Text('$age'),]),        
            SizedBox(height: 20.0),
          Text(
            
            'GENDER:',
            style: TextStyle(
              color: Colors.pink,
              fontSize: 18.0,
            ),
            textAlign: TextAlign.left ,
          ),
          RadioListTile(
            title: Text(
              'MALE',
              style: TextStyle(
                color : Colors.black,
              ),
              ),
            value: 'MALE',
            activeColor: Colors.pink, 
            groupValue: gender, 
            onChanged: (val){
              setState(() {
                gender =val; 
              });
            }
            ),
            RadioListTile(
              title: Text('FEMALE',
              style: TextStyle(
                //color: Colors.pink,
              ) ,
              ),
              activeColor: Colors.pink, 
            value: 'FEMALE', 
            groupValue: gender, 
            onChanged: (val){
              setState(() {
                gender =val; 
              });
            }
            ),
            RadioListTile(
              title: Text('OTHERS',
              style: TextStyle(
                //color: Colors.pink,
              ),
              ),
              activeColor: Colors.pink, 
            value: 'OTHERS', 
            groupValue: gender, 
            onChanged: (val){
              setState(() {
                gender =val; 
              });
            }
            ),
            
        //  DropdownButtonFormField(
        //     value: gender ?? 'MALE',
        //     items: genders.map((gen){
        //  return DropdownMenuItem(value: gen,child: Text(gen));
        //            }).toList(),
                   
        //  onChanged: (val)
        //  {
        //     setState(() => gender = val);
        //  }),
            SizedBox(height: 20.0),
         TextFormField(
           decoration: InputDecoration(
                   //contentPadding: EdgeInsets.only(right: 20.0),
                   labelText: "Enter Bio",
                   labelStyle: TextStyle(
          color: Colors.pink,
          //letterSpacing: 2.0,
                   ),
                   
                   fillColor: Colors.white,
                   border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
          borderSide: BorderSide(
          ),
                   ),
            ),
         validator: (val) => val.isEmpty ? 'Enter a small bio':null,
         onChanged: (val)
         {
            setState(() => bio = val);
         }),
            SizedBox(height: 20.0),
            // RaisedButton(child: Text('Sign up'),
            // color: Colors.cyan,
            RaisedButton (
              padding: EdgeInsets.all(0.0),
             shape: RoundedRectangleBorder(
               borderRadius: BorderRadius.circular(20.0),

              ),
              child: Ink(
                padding: EdgeInsets.all(0.0),
    decoration: const BoxDecoration(
        //shape: BoxShape.rectangle,
        gradient: LinearGradient(colors: aquaGradients ),
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
    ),
    child: Container(
        constraints: const BoxConstraints(minWidth: 150.0, minHeight: 40.0), // min sizes for Material buttons
        alignment: Alignment.center,
        child: const Text(
          'REGISTER',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 18.0,
            color: Colors.white,
          ),
        ),
    ),),
            onPressed:() async {
         if(_formkey.currentState.validate())
                   { setState(() {
            loading =true;
                   });
             dynamic result = await _auth.registerwithEmailandPassword(email, password,name,age,bio,gender,url);
             loading = true;
                   if(result == null)
                   {
            
            setState(() {
           loading = false;
          error = 'Please supply a valid credentials !!  ';
            });
                   }
                   }

            },),
            FlatButton(
                 
                 //hoverColor: Colors.pink,
                 child: Text(
                   'Already have an account? Login now',
                   ),
                 onPressed: (){
                   widget.toggleView();
                 }
                 ),
            SizedBox(height : 12.0),
            Expanded(child: 
            Text(error,
            style : TextStyle(
         color:  Colors.black,
         fontWeight : FontWeight.bold,
         fontSize : 15.0,

            ),)),
    
       Stack(
                alignment: Alignment.bottomLeft,
                children: <Widget>[
                  WavyFooter(),
                  CirclePink(),
                  CircleYellow(),
                ],
              ),

    ]

            )

          ),
                   ),
              ),
              ),
     ),
     )
    
   
      
    );
  }
  }
  const List<Color> aquaGradients = [
  Color(0xFF5AEAF1),
  Color(0xFF8EF7DA),
];