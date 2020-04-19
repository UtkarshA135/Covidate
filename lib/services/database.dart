import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covidate/models/cards.dart';
import 'package:covidate/models/users.dart';
class DatabaseService
{ 
  final String uid;
  DatabaseService({
    this.uid
  });

final CollectionReference userCollection = Firestore.instance.collection('users');


Future updateUserData( String name , int age , String bio, String gender , String url, String uid)
async
{
  return await userCollection.document(uid).setData({
    //'imageURL ': imageURL,
    'name' : name,
    'age' : age,
    'bio' : bio,
    'gender' : gender,
    'url' : url,
    'ownerid': uid,
    'mylikes' : { uid : true},
    'likes' : { uid : true},
  
   } );
   
}

List<Cards>_cardlistfromsnapshot(QuerySnapshot snapshot){
  return snapshot.documents.map((doc){
   return Cards(
     age : doc.data['age'] ?? 0 ,
     name: doc.data['name'] ?? '',
     gender: doc.data['gender'] ?? '',
     bio : doc.data['bio'] ?? '',
     url: doc.data['url'] ?? '',
     ownerid: doc.data['ownerid'] ??'',
     mylikes: doc.data['mylikes'],
     likes:  doc.data['likes']
    
   );}).toList();
  
}
UserData _userDatafromSnapshot(DocumentSnapshot snapshot){
  return UserData(gender: snapshot.data['gender'],
    age: snapshot.data['age'],
    bio : snapshot.data['bio'],
    name : snapshot.data['name'],
    uid : uid,
    url:  snapshot.data['url'],
    likes: snapshot.data['likes'],
    mylikes : snapshot.data['mylikes'],
   );
}
Stream<List<Cards>> get cards{
  return userCollection.snapshots().map(_cardlistfromsnapshot);
}
Stream<UserData> get userData{
  return userCollection.document(uid).snapshots().map(_userDatafromSnapshot);
}
}