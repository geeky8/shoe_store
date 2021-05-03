import 'package:a_commerce/screens/product_page.dart';
import 'package:a_commerce/utilites/constants.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final Function onPress;
  final String imageUrl;
  final String title;
  final String price;
  final String product_id;

  ProductCard({this.onPress,this.title,this.imageUrl,this.price,this.product_id});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.0)
        ),
        height: 300.0,
        margin: EdgeInsets.symmetric(
            vertical: 12.0, horizontal: 24.0),
        child: Stack(
          children: [
            Container(
              height: 300.0,
              child: ClipRRect(
                child: Image.network(
                  '$imageUrl',
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(12.0),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('$title ' ?? 'Product name',style: kdescriptionstyle,),
                    Text('\$$price' ?? 'Price',style: TextStyle(color: Theme.of(context).accentColor,fontSize: 16.0,fontWeight: FontWeight.w600),),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
