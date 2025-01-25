import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String name;
  String profilePhoto;
  String email;
  String phoneNumber;
  String uid;

  User ({
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.profilePhoto,
    required this.uid
  });

  Map<String, dynamic> toJson() => {
    "name" : name,
    "email" : email,
    "phoneNumber" : phoneNumber,
    "profilePhoto" : profilePhoto,
    "uid" : uid
  };

  static User fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return User(
    name: snapshot['name'],
    email: snapshot['email'],
    phoneNumber: snapshot['phoneNumber'],
    profilePhoto: snapshot['profilePhoto'],
    uid: snapshot['uid']
    );
  }
}