import 'package:a_commerce/screens/homepage.dart';
import 'package:a_commerce/screens/landingpage.dart';
import 'package:a_commerce/screens/login.dart';
import 'package:a_commerce/screens/product_page.dart';
import 'package:a_commerce/screens/register.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(
          Theme.of(context).textTheme,
        ),
        accentColor: Color(0xFFFF1E00),
      ),
      home: LandingPage(),
      routes: {
        'home':(context) => Home(),
        'login':(context) => Login(),
        'register':(context) => Register(),
        'product':(context) => ProductPage(),
      },
    );
  }
}

