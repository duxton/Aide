import 'package:cloud_firestore/cloud_firestore.dart';


class Users {
  final String id;
  final String username;
  final String email;
  final String photoUrl;
  final String displayName;

  Users({
    this.id,
    this.username,
    this.email,
    this.photoUrl,
    this.displayName,
  });

  factory Users.fromDocument(DocumentSnapshot doc) {
    return Users(
      id: doc.data()['id'],
      email: doc.data()['email'],
      username: doc.data()['username'],
      photoUrl: doc.data()['photoUrl'],
      displayName: doc.data()['displayName'],
     
    );
  }
}
