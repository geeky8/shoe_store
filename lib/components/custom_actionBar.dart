import 'package:a_commerce/screens/cart_page.dart';
import 'package:a_commerce/screens/upload_product.dart';
import 'package:a_commerce/services/firebase_services.dart';
import 'package:a_commerce/utilites/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CustomActionBar extends StatelessWidget {
  final String title;
  final int pgno;
  final bool hasbackarrow;
  final bool hasTitle;
  final bool hasbackground;
  final bool isbackarrow;

  CustomActionBar(
      {this.title,
      this.pgno,
      this.hasbackarrow,
      this.hasTitle,
      this.hasbackground,
      this.isbackarrow});

  FirebaseServices _firebaseServices = FirebaseServices();

  final CollectionReference _usersRef =
      FirebaseFirestore.instance.collection('Users');

  @override
  Widget build(BuildContext context) {
    bool _hasbackarrow = hasbackarrow ?? false;
    bool _hasTitle = hasTitle ?? true;
    bool _hasbackground = hasbackground ?? true;
    int price = 0;
    bool _isbackarrow = isbackarrow ?? false;

    return Container(
      decoration: BoxDecoration(
          gradient: _hasbackground
              ? LinearGradient(colors: [
                  Colors.white,
                  Colors.white.withOpacity(0),
                ], begin: Alignment(0, 0), end: Alignment(0, 1))
              : null),
      padding:
          EdgeInsets.only(top: 60.0, left: 24.0, right: 24.0, bottom: 42.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (_hasbackarrow)
            GestureDetector(
              onTap: () {
                if (isbackarrow) {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => UploadProduct()));
                }
                else{
                  Navigator.pop(context);
                }
              },
              child: Container(
                width: 42.0,
                height: 42.0,
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(8.0)),
                alignment: Alignment.center,
                child: Icon(
                  isbackarrow?Icons.add:Icons.arrow_back_ios_rounded,
                  size: 19.0,
                  color: Colors.white,
                ),
              ),
            ),
          Text(
            _hasTitle ? title ?? 'ACTIONBAR' : '',
            style: kheadstyle,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CartPage(),
                  ));
            },
            child: Container(
                width: 42.0,
                height: 42.0,
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(8.0)),
                alignment: Alignment.center,
                child: StreamBuilder(
                  stream: _usersRef
                      .doc(_firebaseServices.getUserid())
                      .collection('Cart')
                      .snapshots(),
                  builder: (context, snapshot) {
                    int _totalItems = 0;

                    if (snapshot.connectionState == ConnectionState.active) {
                      List _documents = snapshot.data.docs;
                      _totalItems = _documents.length;
                    }

                    return Text(
                      _totalItems.toString() ?? '0',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w600),
                    );
                  },
                )),
          )
        ],
      ),
    );
  }
}
