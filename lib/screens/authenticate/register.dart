

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

        
   
 appBar: AppBar(
      backgroundColor : Colors.orange[800],
      title : Text('Sign-Up'),
      actions :<Widget>[
        FlatButton.icon(onPressed: (){
          widget.toggleView();
        }, icon: Icon(Icons.person), label: Text('Sign-In')),
      ]

    ),
    body: SingleChildScrollView(
       
      // padding: EdgeInsets.symmetric(vertical : 20.0 , horizontal : 50.0),
      child : IntrinsicHeight(
        child : Container(
          padding: EdgeInsets.symmetric(vertical : 20.0 , horizontal : 50.0),
          decoration: BoxDecoration(
       
        gradient : LinearGradient(colors: [Colors.orange[400],Colors.orange[900],Colors.orange,Colors.red[700],Colors.red[900]],
         begin : Alignment.topCenter,
        end : Alignment.bottomCenter,
        stops: [0.2,0.4,0.6,0.8,1.0])
      ),
      child : Form(
        key: _formkey,
         child : Column(
        children: <Widget> [
        
          SizedBox(height: 20.0),
         Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children : <Widget>[
              Align(
                alignment : Alignment.center,
                child : CircleAvatar(
                  radius: 100,
                  backgroundColor: Colors.grey[400],
                  child:  ClipOval(
                    
                    child : SizedBox(
                    width : 180,
                     height : 180,
                     
                     child:(_image!=null)? Image.file( _image,fit : BoxFit.fill): Image.asset('assets/popo.jpg',fit:BoxFit.fill),
                  ),
                  ),
                
                  ),
              ),
              Padding(
                padding:  EdgeInsets.only(top : 60.0),
                child:  IconButton(icon: Icon( Icons.camera, size: 30.0), onPressed: (){
                  getImage();
                }),
              ),
              Padding(padding: EdgeInsets.only(top : 60.0),
              child:IconButton( icon : Icon(Icons.file_upload),onPressed :() async { await uploadImage();} ),
              )
              ],),
            Expanded(child: 
         TextFormField(
           
           validator: (val) => val.isEmpty ? 'Enter an Email':null,
           onChanged: (val)
           {
            setState(() => email = val);
           }),
            ),
         SizedBox(height: 20.0),
         Expanded(child: 
         TextFormField(
           validator: (val) => val.length < 6 ? 'Enter a password of atleast 6 characters':null,
           obscureText: true,
           onChanged : (val){
             setState(() =>
               password=val
        );

           },
         ),),
         SizedBox(height : 20.0),
         Expanded(child: 
           TextFormField(
             
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
             activeColor: Colors.pink[900],
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
           DropdownButtonFormField(
            value: gender ?? 'MALE',
            items: genders.map((gen){
           return DropdownMenuItem(value: gen,child: Text(gen));
          }).toList(),
          
           onChanged: (val)
           {
            setState(() => gender = val);
           }),
         SizedBox(height: 20.0),
           Expanded(
             child :TextFormField(
           validator: (val) => val.isEmpty ? 'Enter a small bio':null,
           onChanged: (val)
           {
            setState(() => bio = val);
           }),),
         SizedBox(height: 20.0),
         Expanded(child: 
         RaisedButton(child: Text('Sign up'),
         color: Colors.cyan,
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

         },),),
         SizedBox(height : 12.0),
         Expanded(child: 
         Text(error,
         style : TextStyle(
           color:  Colors.black,
           fontWeight : FontWeight.bold,
           fontSize : 15.0,

         ),)),
        ]

      )

      ))
    ),
   
      
    ) ),);
  }
  }