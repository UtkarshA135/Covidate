import 'package:covidate/screens/authenticate/authenticate.dart';
import 'package:covidate/screens/authenticate/signup.dart';
import 'package:covidate/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:covidate/models/users.dart';
import 'package:covidate/screens/home/chat.dart';
import 'package:covidate/services/auth.dart';
import 'package:covidate/screens/home/pagecontroller.dart';
//import 'package:covidate/screens/home/pagecontroller.dart';
class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

   if (user == null)
   {
   
     return Authenticate();
   }
   else 
   return NavigatoBAR();
      
   
  }
}