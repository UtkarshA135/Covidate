import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:covidate/models/users.dart';
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

Future registerwithEmailandPassword(String email, String password) async {
      
     try {
       print(email);
       print(password);
       AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
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
   Future signOut()
    async {
     try{ return await _auth.signOut();
   }
   catch(e)
   { 
     print(e.toString());
     return null;
   }}
}
