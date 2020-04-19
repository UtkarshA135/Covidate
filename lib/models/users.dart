
class User
{
  String uid;
  User({this.uid});
}
class UserData
{
  final String uid;
  final String name;
  final int age;
  final String gender;
  final String bio;
  final String url;
  final Map likes;
  final Map mylikes;
  UserData({this.uid,this.name,this.age,this.gender,this.bio,this.url,this.likes,this.mylikes});
}