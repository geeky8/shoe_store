import 'package:flutter/material.dart';

class ImageSlide extends StatefulWidget {
  const ImageSlide({
    @required this.imageList,
    @required this.documentdata,
  }) ;

  final List imageList;
  final Map<String, dynamic> documentdata;

  @override
  _ImageSlideState createState() => _ImageSlideState();
}

class _ImageSlideState extends State<ImageSlide> {
  int _selectedPage = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          PageView(
            onPageChanged: (num){
              setState(() {
                _selectedPage = num;
              });
            },
            children: [
              for(var i=0;i<widget.imageList.length;i++)
                Container(
                  child: Image.network('${widget.documentdata['images'][i]}',fit: BoxFit.cover,),
                ),
            ],
          ),
          Positioned(
            bottom: 20.0,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for(var i=0;i<widget.imageList.length;i++)
                  AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeOutCubic,
                    margin: EdgeInsets.symmetric(horizontal: 5.0),
                    height: 10.0,
                    width: _selectedPage==i ? 35.0 : 10.0,
                    decoration: BoxDecoration(
                        color: Colors.black54.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(12.0)
                    ),
                  ),
              ],
            ),
          )
        ],
      ),
      height: 350.0,
    );
  }
}
