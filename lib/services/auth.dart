
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covidate/screens/authenticate/register.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:covidate/models/users.dart';
import 'database.dart';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

// class ImageUploadGet extends StatefulWidget {
//   @override
//   _ImageUploadGetState createState() => _ImageUploadGetState();
// }

// class _ImageUploadGetState extends State<ImageUploadGet> {
//   @override
//   Widget build(BuildContext context) {
//    String url;
// File _image;
// Future  getImage() async {
// var image = await ImagePicker.pickImage( source : ImageSource.gallery);
// setState (()
// {
//     _image = image;
//  }
//  );
// }

// Future  uploadImage() async{
// final StorageReference postImgref = FirebaseStorage.instance.ref().child('Post Images');
// var timeKey = new DateTime.now();
// final StorageUploadTask uploadTask = postImgref.child(timeKey.toString()+'.jpg').putFile(_image);
// var imgurl = await(await uploadTask.onComplete).ref.getDownloadURL();
// url = imgurl.toString();
// print(url);
//  }

//   }
// }


class AuthService
{
 
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User _userfromFirebaseUser(FirebaseUser user){
    return user!=null ? User(uid : user.uid) : null;
  }
Stream<User> get user{
  return _auth.onAuthStateChanged
  .map(_userfromFirebaseUser);
}


Future registerwithEmailandPassword(String email, String password , String name,int age , String bio, String gender , String url) async {
      
     try {
       print(email);
       print(password);
        print(name);
         print(age);
          print(bio);
           print(gender);
           print(url);
       AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
       await DatabaseService(uid: user.uid).updateUserData(name, age, bio, gender,url,user.uid);
      
       await user.sendEmailVerification();
        
        return _userfromFirebaseUser(user);
     } catch (e) {
        print("An error occured while trying to send email verification");
        print(e.message);
        return null;
     }

   }
   Future signInwithEmailandPassword(String email, String password) async{
     try{
        AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
       if (user.isEmailVerified)
        
        return _userfromFirebaseUser(user);
        else
        return null;
     }catch(e)
     {
       print("An error occured while trying to send email verification");
        print(e.message);
        return null;
     }
   }
    Future sendPasswordResetEmail(String email) async {
    return _auth.sendPasswordResetEmail(email: email);
  }
   Future signOut()
    async {
     try{ return await _auth.signOut();
   }
   catch(e)
   { 
     print(e.toString());
     return null;
   }}
   Future<String> getUserID() async{
     return ( await _auth.currentUser()).uid;
   }
    Future<FirebaseUser>getCurrentUser() async{
     return  await _auth.currentUser();
   }
}
