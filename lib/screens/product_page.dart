import 'package:a_commerce/components/custom_actionBar.dart';
import 'package:a_commerce/components/image_slide.dart';
import 'package:a_commerce/components/product_size.dart';
import 'package:a_commerce/services/firebase_services.dart';
import 'package:a_commerce/utilites/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductPage extends StatefulWidget {
  final String id;

  ProductPage({this.id});

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  FirebaseServices _firebaseServices = FirebaseServices();



  Future _addCart() {
    return _firebaseServices.usersRef
        .doc(_firebaseServices.getUserid())
        .collection('Cart')
        .doc(widget.id)
        .set({'size': _selected});
  }

  Future _addSaved() {
    return _firebaseServices.usersRef
        .doc(_firebaseServices.getUserid())
        .collection('Saved')
        .doc(widget.id)
        .set({'size': _selected});
  }

  String _selected = '0';

  final SnackBar _snackBar_cart = SnackBar(content: Text('Product added to cart'));
  final SnackBar _snackBar_saved = SnackBar(content: Text('Product saved'));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FutureBuilder(
            future: _firebaseServices.productsRef.doc(widget.id).get(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Scaffold(
                  body: Center(
                    child: Text('not Successful', style: kheadstyle),
                  ),
                );
              }

              if (snapshot.connectionState == ConnectionState.done) {
                //firebase document data map
                Map<String, dynamic> documentdata = snapshot.data.data();

                //list of images of product
                List imageList = documentdata['images'];
                List productSize = documentdata['size'];

                return ListView(
                  children: [
                    ImageSlide(
                        imageList: imageList, documentdata: documentdata),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 24.0, left: 24.0, right: 24.0, bottom: 4.0),
                      child: Text(
                        '${documentdata['name']}' ?? 'Product Name',
                        style: kBoldheadstyle,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 4.0, horizontal: 24.0),
                      child: Text(
                        '\$${documentdata['price']}' ?? 'price',
                        style: TextStyle(
                            color: Theme.of(context).accentColor,
                            fontSize: 16.0,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 24.0),
                      child: Text(
                        '${documentdata['desc']}' ?? 'description',
                        style: TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 24.0, horizontal: 24.0),
                      child: Text(
                        'Select Size',
                        style: kheadstyle,
                      ),
                    ),
                    ProductSize(
                      productSize: productSize,
                      documentdata: documentdata,
                      selected: (value) {
                        _selected = value;
                      },
                    ),
                    SizedBox(
                      height: 40.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: ()async {
                              await _addSaved();
                              Scaffold.of(context).showSnackBar(_snackBar_saved);
                            },
                            child: Container(
                              child: Icon(
                                Icons.bookmark_border,
                                size: 27.0,
                              ),
                              width: 65.0,
                              height: 65.0,
                              decoration: BoxDecoration(
                                  color: Color(0xFFDCDCDC),
                                  borderRadius: BorderRadius.circular(12.0)),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () async {
                                await _addCart();
                                Scaffold.of(context).showSnackBar(_snackBar_cart);
                              },
                              child: Container(
                                child: Text(
                                  'ADD TO CART',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14.0),
                                ),
                                decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(12.0)),
                                height: 65.0,
                                alignment: Alignment.center,
                                margin: EdgeInsets.only(left: 16.0),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }

              // user in loading state
              return Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            },
          ),
          CustomActionBar(
            hasTitle: false,
            hasbackarrow: true,
            pgno: 1,
            hasbackground: false,
          )
        ],
      ),
    );
  }
}
