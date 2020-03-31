import 'package:cloud_firestore/cloud_firestore.dart';
class DatabaseService
{ 
  final String uid;
  DatabaseService({
    this.uid
  });

final CollectionReference userCollection = Firestore.instance.collection('users');

Future updateUserData( String name , int age , String bio, String gender, String url)
async
{
  return await userCollection.document(uid).setData({
    //'imageURL ': imageURL,
    'name' : name,
    'age' : age,
    'bio' : bio,
    'gender' : gender,
    'url' : url
   } );
}
}