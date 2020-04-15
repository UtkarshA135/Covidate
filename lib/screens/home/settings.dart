import 'package:covidate/screens/userProfile/background.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/widgets.dart';
import 'package:covidate/services/auth.dart';
import 'package:covidate/services/database.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:covidate/models/users.dart';
class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final AuthService _auth = AuthService();
  final _formkey = GlobalKey<FormState>();
  final List<String> genders = ['MALE' , 'FEMALE' ,'OTHERS'];
 File _image;
  String name ;
int  age ;
 String gender;
 String bio ;
 String error ;
 bool loading = false;
 String url;
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
    final user = Provider.of<User>(context);
    return  GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child : SingleChildScrollView(
      child : IntrinsicHeight(child: 
       StreamBuilder<UserData>(
         stream: DatabaseService(uid : user.uid).userData,
         builder: (context,snapshot){
           if(snapshot.hasData)
           {
            UserData  userData = snapshot.data;
            return Form(
        key: _formkey,
         child : Column(
        children: <Widget> [
        
          SizedBox(height: 20.0),
              Center(child: 
         Text('Revamp your profile',
         style: TextStyle(
           fontSize :25.0,
           fontFamily: 'Lobster'
         ),
           
           
         ),
            ),
         Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children : <Widget>[
              Align(
                alignment : Alignment.center,
                child : CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.grey[400],
                  child:  ClipOval(
                    
                    child : SizedBox(
                    width : 180,
                     height : 180,
                     
                     child:(_image!=null)? Image.file( _image,fit : BoxFit.fill): Image.network(userData.url,fit:BoxFit.fill),
                  ),
                  ),
                
                  ),
              ),
              Padding(
                padding:  EdgeInsets.only(top : 60.0),
                child:  IconButton(icon: Icon( Icons.camera, size: 20.0), onPressed: (){
                  getImage();
                }),
              ),
              Padding(padding: EdgeInsets.only(top : 60.0),
              child:IconButton( icon : Icon(Icons.file_upload, size: 20.0,),onPressed :() async { await uploadImage();} ),
              )
              ],),
        
         SizedBox(height: 20.0),
         Expanded(child: 
           TextFormField(
             decoration: InputDecoration(
               labelText: 'Enter Name',
               labelStyle: TextStyle(
                 color: Colors.pink
               ),
               //prefixIcon: Icon(Icons.person, color: Colors.pink,),
               border: OutlineInputBorder(
                 borderRadius: BorderRadius.circular(50.0)
               )
             ),
             initialValue: userData.name,
           validator: (val) => val.isEmpty ? 'Enter a valid name':null,
           onChanged: (val)
           { 
            setState(() => name = val);
           }),),
         SizedBox(height: 20.0),
         SingleChildScrollView(
           scrollDirection: Axis.horizontal,
           child: Row(
           children : <Widget>[
             Text('Age'),
             SizedBox(width : 5.0),
          Slider(
             value: ( age ?? userData.age).toDouble(),
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
           Text('$age'?? '${userData.age}'),]),),        
            SizedBox(height: 20.0),
           DropdownButtonFormField(
            value: gender ?? userData.gender,
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
               decoration: InputDecoration(
               labelText: 'Enter Bio',
               labelStyle: TextStyle(
                 color: Colors.pink
               ),
              // prefixIcon: Icon(Icons.person, color: Colors.pink,),
               border: OutlineInputBorder(
                 borderRadius: BorderRadius.circular(50.0)
               )
             ),
               initialValue: userData.bio,
           validator: (val) => val.isEmpty ? 'Enter a small bio':null,
           onChanged: (val)
           {
            setState(() => bio = val);
           }),),
         SizedBox(height: 20.0),
         GestureDetector(
           child: Container(
             padding: EdgeInsets.all(8.0),
             width: MediaQuery.of(context).size.width *0.8,
             decoration: BoxDecoration(
               gradient: LinearGradient( colors: aquaGradients),
               borderRadius: BorderRadius.circular(20.0)
             ),
             child: Center(child: Text('Update')),
           ),
           onTap:() async {
           if(_formkey.currentState.validate())
         {
             await DatabaseService(uid : user.uid).updateUserData(name ?? userData.name,
             age ?? userData.age,
             bio ?? userData.bio,
             gender ?? userData.gender,
             url ?? userData.url);
             Navigator.pop(context);
  
         }}
         ),
        //  Expanded(child: 
        //  RaisedButton(child: Text('Update'),
        //  color: Colors.cyan,
        //  onPressed:() async {
        //    if(_formkey.currentState.validate())
        //  {
        //      await DatabaseService(uid : user.uid).updateUserData(name ?? userData.name,
        //      age ?? userData.age,
        //      bio ?? userData.bio,
        //      gender ?? userData.gender,
        //      url ?? userData.url);
        //      Navigator.pop(context);
  
        //  }})),
        ]

      ),);
           }
         } 
       )) ));
}}
