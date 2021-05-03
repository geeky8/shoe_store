import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseServices{
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // user id
  String getUserid(){
    return _firebaseAuth.currentUser.uid;
  }

  final CollectionReference productsRef =
  FirebaseFirestore.instance.collection('Products');

  final CollectionReference usersRef =
  FirebaseFirestore.instance.collection('Users');
}