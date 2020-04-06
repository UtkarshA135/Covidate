import 'package:covidate/screens/home/profile.dart';
import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CustomProfile with ChangeNotifier
{
  String name;
 // String bio;
  String photos;
 CustomProfile({this.photos,this.name});
  factory CustomProfile.fromDocument(DocumentSnapshot document)
  {
    return CustomProfile(
      name : document['name'] ?? '',
      photos: document['url'] ?? ''

    );

  }
}