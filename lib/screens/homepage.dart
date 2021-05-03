import 'package:a_commerce/components/Bottom_tab.dart';
import 'package:a_commerce/tabs/home_tab.dart';
import 'package:a_commerce/tabs/saved_tab.dart';
import 'package:a_commerce/tabs/search_tab.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:a_commerce/utilites/constants.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  PageController _tabspageControl;
  int selectedPage;

  @override
  void initState() {
    _tabspageControl = PageController();
    super.initState();
  }

  @override
  void dispose() {
    _tabspageControl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: PageView(
              controller: _tabspageControl,
              onPageChanged: (num) {
                setState(() {
                  selectedPage = num;
                });
              },
              children: [
                HomeTab(),
                SearchTab(),
                SavedTab()
              ],
            ),
          ),
          Bottom_tab(
              BottomSelection: selectedPage,
              tabCLicked: (num) {
                _tabspageControl.animateToPage(num, duration: Duration(milliseconds: 300), curve: Curves.easeOutCubic);
              })
        ],
      ),
    );
  }
}
