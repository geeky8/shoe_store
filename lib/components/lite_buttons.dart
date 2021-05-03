import 'package:a_commerce/utilites/constants.dart';
import 'package:flutter/material.dart';

class LiteButton extends StatelessWidget {
  final String text;
  final Function onpressed;
  final bool but;
  final bool isLoading;
  LiteButton({this.text, this.onpressed, this.but, this.isLoading});

  @override
  Widget build(BuildContext context) {
    bool _but = but ?? false;
    bool _isLoading = isLoading ?? false;
    return GestureDetector(
      onTap: onpressed,
      child: Container(
        height: 60.0,
        decoration: BoxDecoration(
          color: _but ? Colors.transparent : Colors.black,
          border: Border.all(color: Colors.black, width: 2.0),
          borderRadius: BorderRadius.circular(7.0),
        ),
        margin: EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
        child: Stack(
          children: [
            Visibility(
              visible: _isLoading ? false : true,
              child: Center(
                child: Text(
                  text,
                  style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                      color: but ? Colors.black : Colors.white),
                ),
              ),
            ),
            Visibility(
              child: Center(
                  child: SizedBox(
                child: CircularProgressIndicator(),
                width: 30.0,
                height: 30.0,
              )),
              visible: _isLoading ? true : false,
            )
          ],
        ),
      ),
    );
  }
}
