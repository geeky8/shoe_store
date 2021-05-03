import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Bottom_tab extends StatefulWidget {
  final int BottomSelection;
  final Function(int) tabCLicked;
  Bottom_tab({this.BottomSelection,this.tabCLicked});

  @override
  _Bottom_tabState createState() => _Bottom_tabState();
}

class _Bottom_tabState extends State<Bottom_tab> {
  int _selectedTab;


  @override
  Widget build(BuildContext context) {
    _selectedTab = widget.BottomSelection??0;
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12.0), topRight: Radius.circular(12.0)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              spreadRadius: 1.0,
              blurRadius: 25.0,
            )
          ]),
      padding: EdgeInsets.only(bottom: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          BottomTabBtn(
              icon: Icons.home_outlined,
              selected: _selectedTab == 0 ? true : false,
              onpress: (){
                widget.tabCLicked(0);
              },
          ),
          BottomTabBtn(
            icon: Icons.search_rounded,
            selected: _selectedTab == 1 ? true : false,
            onpress: (){
              widget.tabCLicked(1);
            },
          ),
          BottomTabBtn(
            icon: Icons.bookmark_border,
            selected: _selectedTab == 2 ? true : false,
            onpress: (){
              widget.tabCLicked(2);
            },
          ),
          BottomTabBtn(
            icon: Icons.logout,
            selected: _selectedTab == 3 ? true : false,
            onpress: (){
              FirebaseAuth.instance.signOut();
            },
          )
        ],
      ),
    );
  }
}

class BottomTabBtn extends StatelessWidget {
  final IconData icon;
  final bool selected;
  final Function onpress;

  BottomTabBtn({this.icon, this.selected, this.onpress});

  @override
  Widget build(BuildContext context) {
    bool _selected = selected ?? false;
    return GestureDetector(
      onTap: onpress,
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: _selected
                  ? Theme.of(context).accentColor
                  : Colors.transparent,
              width: 2.0,
            ),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.only(top: 5.0),
          child: Icon(
            icon,
            size: 25.0,
            color: _selected ? Theme.of(context).accentColor : Colors.black,
          ),
        ),
        width: 53.0,
        height: 35.0,
      ),
    );
  }
}
