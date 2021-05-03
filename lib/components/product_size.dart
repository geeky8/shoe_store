import 'package:a_commerce/services/firebase_services.dart';
import 'package:flutter/material.dart';

class ProductSize extends StatefulWidget {
  const ProductSize({
    @required this.productSize,
    @required this.documentdata,
    this.selected
  });

  final List productSize;
  final Function(String) selected;
  final Map<String, dynamic> documentdata;

  @override
  _ProductSizeState createState() => _ProductSizeState();
}

class _ProductSizeState extends State<ProductSize> {
  int _selected = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0),
      child: Row(
        children: [
          for(var i=0;i<widget.productSize.length;i++)
            GestureDetector(
              onTap: (){
                widget.selected(widget.productSize[i].toString());
                setState(() {
                  _selected = i;
                });
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 4.0),
                height: 40.0,
                width: 40.0,
                decoration: BoxDecoration(
                  color: _selected==i?Theme.of(context).accentColor:Color(0xFFDCDCDC),
                  borderRadius: BorderRadius.circular(8.0)
                ),
                child: Text('${widget.documentdata['size'][i]}',style: TextStyle(color: _selected==i?Colors.white:Colors.black,fontWeight: FontWeight.w600,fontSize: 17.0),),
                alignment: Alignment.center,
              ),
            ),
        ],
      ),
    );
  }
}

