import 'package:a_commerce/screens/homepage.dart';
import 'package:a_commerce/screens/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:a_commerce/utilites/constants.dart';

class LandingPage extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        //snapshot has error
        if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text('not Successful', style: kheadstyle),
            ),
          );
        }
        //connection successful
        if (snapshot.connectionState == ConnectionState.done) {
          //streambuilder can check live login state
          return StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, streamsnapshot) {
              //if streamsnapshot has error
              if (streamsnapshot.hasError) {
                return Scaffold(
                  body: Center(
                    child: Text('not Successful', style: kheadstyle),
                  ),
                );
              }
              //checking connection state active - check for logged in user inside
              if(streamsnapshot.connectionState == ConnectionState.active){
                User _user= streamsnapshot.data;

                //if user is not logged in
                if(_user==null){
                  return Login();
                }
                //user is logged in
                else{
                  return Home();
                }

              }

              //auth state checking
              return Scaffold(
                body: Center(
                  child: Text(
                    'checking auth',
                    style: kheadstyle,
                  ),
                ),
              );
            },
          );
        }
        return Scaffold(
          body: Center(
            child: Text(
              'intializing......',
              style: kheadstyle,
            ),
          ),
        );
      },
    );
  }
}
