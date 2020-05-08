import 'package:covidate/screens/home/all_users_screen.dart';
import 'dart:io';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covidate/screens/home/background.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
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
 String name = ' ';
int  age = 18 ;
 String gender;
 String bio = '';
 String error ='';
 bool loading = false;
 String url;
class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formkey = GlobalKey<FormState>();
  final List<String> genders = ['MALE' , 'FEMALE' ,'OTHERS'];
 File _image;
 final CollectionReference matchRef = Firestore.instance.collection('matches');
 bool _isvisible= true;
 void toggleVisibility(){
   setState(() {
     _isvisible = !_isvisible;
  });
}
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

        
   
//  appBar: AppBar(
//       backgroundColor : Colors.orange[800],
//       title : Text('Sign-Up'),
//       actions :<Widget>[
//         FlatButton.icon(onPressed: (){
//           widget.toggleView();
//         }, icon: Icon(Icons.person), label: Text('Sign-In')),
//       ]

//     ),
    body: SingleChildScrollView(
       
      // padding: EdgeInsets.symmetric(vertical : 20.0 , horizontal : 50.0),
      child : IntrinsicHeight(
        child : Container(
          color: Colors.white,
        padding: EdgeInsets.symmetric(vertical : 20.0 , horizontal : 20.0),
      //     decoration: BoxDecoration(
       
      //   gradient : LinearGradient(colors: [Colors.orange[400],Colors.orange[900],Colors.orange,Colors.red[700],Colors.red[900]],
      //    begin : Alignment.topCenter,
      //   end : Alignment.bottomCenter,
      //   stops: [0.2,0.4,0.6,0.8,1.0])
      // ),
      child : Form(
        key: _formkey,
         child : Column(
        children: <Widget> [
        
          SizedBox(height: 20.0),
              Align(
                alignment : Alignment.center,
                child : CircleAvatar(
                  radius: 100,
                  backgroundColor: Colors.grey[400],
                  child:  ClipOval(
                    
                    child : SizedBox(
                    width : 180,
                     height : 180,
                     
                     child:(_image!=null)? Image.file( _image,fit : BoxFit.fill): Image.network('https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcTiJiDlfMaWW0ATIedRlCUByLXqJvRhLHrzdhDTNSYWx_73D_o6&usqp=CAU',fit:BoxFit.fill),
                  ),
                  ),
                
                  ),
              ),
            SizedBox(height: 15.0),
         Row(
           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children : <Widget>[
              FlatButton.icon(icon: Icon( Icons.camera, size: 30.0),label: Text('Choose Image',style: TextStyle(color: Colors.pink
               ),), onPressed: (){
                getImage();
              }),
              FlatButton.icon( label: Text('Upload Image', style: TextStyle(color: Colors.pink
               ),),icon : Icon(Icons.file_upload),onPressed :() async { await uploadImage();} )
              ],),
            Expanded(child: 
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
            ),
         SizedBox(height: 20.0),
         Expanded(child: 
         TextFormField(
           decoration: InputDecoration(
               labelText: 'Enter password',
               labelStyle: TextStyle(
                 color: Colors.pink
               ),
               prefixIcon: Icon(Icons.lock, color: Colors.pink,),
               border: OutlineInputBorder(
                 borderRadius: BorderRadius.circular(50.0)
               ),
               suffixIcon: IconButton(
                 onPressed: toggleVisibility,
                 icon: Icon(!_isvisible? Icons.visibility: Icons.visibility_off))
             ),
           validator: (val) => val.length < 6 ? 'Enter a password of atleast 6 characters':null,
          //  obscureText: true,
          obscureText: _isvisible,
           onChanged : (val){
             setState(() =>
               password=val
        );

           },
         ),),
         SizedBox(height : 20.0),
         Expanded(child: 
           TextFormField(
            decoration: InputDecoration(
               labelText: 'Enter Name',
               labelStyle: TextStyle(
                 color: Colors.pink
               ),
              // prefixIcon: Icon(Icons.person, color: Colors.pink,),
               border: OutlineInputBorder(
                 borderRadius: BorderRadius.circular(50.0)
               )
             ),
           validator: (val) => val.isEmpty ? 'Enter a valid name':null,
           onChanged: (val)
           { 
            setState(() => name = val);
           }),),
         SizedBox(height: 20.0),
         Expanded(child: Row(
           children : <Widget>[
             Text('Age'),
             SizedBox(width : 5.0),
          Slider(
             value: ( age ?? 18.0).toDouble(),
             activeColor: Colors.pink,
             min : 18.0,
             max : 30.0,
             divisions: 12,
           onChanged: (val)
           {
            setState(() => age = val.round());
           }
           ),
           SizedBox(width : 5.0),
           Text('$age'),]),),        
            SizedBox(height: 20.0),
          //  DropdownButtonFormField(
          //   value: gender ?? 'MALE',
          //   items: genders.map((gen){
          //  return DropdownMenuItem(value: gen,child: Text(gen));
          // }).toList(),
           SizedBox(height:10.0),
           Align(
             alignment: Alignment.centerLeft,
             child:Text('Gender:')),
           SizedBox(height:10.0),
            Row(
              children: <Widget>[
                Radio(
                value:  'MALE',
                groupValue: gender,
           onChanged: (val)
           {
            setState(() => gender = val);
           }),
           Text('Male'),
            
             ],),
            Row(
              children: <Widget>[
                Radio(
                value:  'FEMALE',
                groupValue: gender,
           onChanged: (val)
           {
              setState(() => gender = val);
           }),
           Text('Female'),
              ],
            ),
            Row(
              children: <Widget>[
               Radio(
                  activeColor: Colors.pink,
                value:  'OTHERS',
                groupValue: gender,
           onChanged: (val)
           {
           {
              setState(() => gender = val);
           }}),
           Text('Others'),
              ],
            ),
        SizedBox(height: 20.0),
          Expanded(
             child :TextFormField(
               decoration: InputDecoration(
               labelText: 'Enter Bio',
               labelStyle: TextStyle(
                 color: Colors.pink
               ),
               //prefixIcon: Icon(Icons.person, color: Colors.pink,),
               border: OutlineInputBorder(
                 borderRadius: BorderRadius.circular(50.0)
               )
             ),
           validator: (val) => val.isEmpty ? 'Enter a small bio':null,
           onChanged: (val)
           {
            setState(() => bio = val);
           }),),
         SizedBox(height: 20.0),
         Expanded(child: 
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
               child: Text('Register' , style: TextStyle(color: Colors.white), textAlign: TextAlign.center,),
             ), 
           ),
         onTap:() async {
           if(_formkey.currentState.validate())
          { setState(() {
            loading =true;
          });
           loading = true;
                  if(url == null)
          {
            setState(() {
               loading = false;
              error = 'Please upload a image !!  ';

            });
          }
           else //
           {
             dynamic result = await _auth.registerwithEmailandPassword(email, password,name,age,bio,gender,url);
            
              
            
          if(result == null)
          {
            
            setState(() {
               loading = false;
              error = 'Please supply a valid credentials !!  ';
            });
          }
        
          
          }
            Navigator.push(context, MaterialPageRoute(builder: (context)=> SignIn() ));
         }},),),
         FlatButton(
             child: Text("Already have an account? Login now"),
             onPressed: (){
            widget.toggleView();
          } ,
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
            )
        ]

      )

      ))
    ),
   
      
    ) ),);
  }
  }