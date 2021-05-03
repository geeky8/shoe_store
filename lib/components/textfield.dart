import 'package:a_commerce/utilites/constants.dart';
import 'package:flutter/material.dart';


class mytextfield extends StatelessWidget {
  final String hinttext;
  final bool pass;
  final Function(String) textchange;
  final TextEditingController control;
  final FocusNode focusNode;
  final Function(String) onSubmit;
  final TextInputAction textInputAction;
  mytextfield({this.hinttext,this.pass,this.textchange,this.control,this.focusNode,this.onSubmit,this.textInputAction});

  @override
  Widget build(BuildContext context) {
    bool _isPassword = pass??false;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24.0,vertical: 8.0),
      decoration: BoxDecoration(
        color: Color(0xffF2F2F2),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: TextField(
        focusNode: focusNode,
        textInputAction: textInputAction,
        onSubmitted: onSubmit,
        controller: control,
        decoration: InputDecoration(border: InputBorder.none,hintText: hinttext,contentPadding: EdgeInsets.symmetric(horizontal: 24.0,vertical: 18.0)),
        style: khintstyle,
        obscureText: _isPassword,
        onChanged: textchange,
      ),
    );
  }
}