import 'package:a_commerce/components/custom_actionBar.dart';
import 'package:a_commerce/screens/payment.dart';
import 'package:a_commerce/screens/product_page.dart';
import 'package:a_commerce/services/firebase_services.dart';
import 'package:a_commerce/utilites/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class CartPage extends StatefulWidget {


  @override
  _CartPageState createState() => _CartPageState();
}
// int tempTotal = snapshot.docs.fold(0, (tot, doc) => tot + doc.data()['price']);
// setState(() {_subTotal = tempTotal;});
class _CartPageState extends State<CartPage> {
  FirebaseServices _firebaseServices = FirebaseServices();
  int _subTotal=0;

  User user = FirebaseAuth.instance.currentUser;

  void total(){
    _firebaseServices.usersRef
        .doc(_firebaseServices.getUserid())
        .collection('Cart')
        .snapshots().forEach((element) {
          print(element.docs.length);
          element.docs.forEach((element) {
            _firebaseServices.productsRef.doc(element.id).snapshots().listen((snapshot) {
              int tot = snapshot.data()['price'];
              setState(() {
                _subTotal += tot;
              });
            });
          });
    });
  }
  @override
  void initState() {
    total();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FutureBuilder<QuerySnapshot>(
            future: _firebaseServices.usersRef
                .doc(_firebaseServices.getUserid())
                .collection('Cart').get(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Scaffold(
                  body: Center(
                    child: Text('not Successful', style: kheadstyle),
                  ),
                );
              }

              //collection data ready to display
              if (snapshot.connectionState == ConnectionState.done) {

                //display the data in list view
                return ListView(
                  padding: EdgeInsets.only(top: 108.0,bottom: 24.0),
                  children: snapshot.data.docs.map((document) {
                    return GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => ProductPage(id: document.id)));
                      },
                      child: FutureBuilder(
                        future: _firebaseServices.productsRef.doc(document.id).get(),
                        builder: (context,productSnap){
                          if(productSnap.hasError){
                            return Container(
                              child: Center(child: Text('${productSnap.error}')),
                            );
                          }

                          if(productSnap.connectionState == ConnectionState.done){
                            Map _productMap = productSnap.data.data();
                            // price += _productMap['price'];
                            // widget.total = price;
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 16.0,
                                horizontal: 24.0,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 90,
                                    height: 90,
                                    child: ClipRRect(
                                      borderRadius:
                                      BorderRadius.circular(8.0),
                                      child: Image.network(
                                        "${_productMap['images'][0]}",
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(
                                      left: 16.0,
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.start,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${_productMap['name']}",
                                          style: TextStyle(
                                              fontSize: 18.0,
                                              color: Colors.black,
                                              fontWeight:
                                              FontWeight.w600),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets
                                              .symmetric(
                                            vertical: 4.0,
                                          ),
                                          child: Text(
                                            "\$${_productMap['price']}",
                                            style: TextStyle(
                                                fontSize: 16.0,
                                                color: Theme.of(context)
                                                    .accentColor,
                                                fontWeight:
                                                FontWeight.w600),
                                          ),
                                        ),
                                        Text(
                                          "Size - ${document.data()['size']}",
                                          style: TextStyle(
                                              fontSize: 16.0,
                                              color: Colors.black,
                                              fontWeight:
                                              FontWeight.w600),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),

                            );
                          }

                          return Container(child: Center(child: CircularProgressIndicator()));
                        },
                      ),
                    );
                  }).toList(),
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
            title: 'Cart',
            hasbackarrow: true,
            hasbackground: true,
            hasTitle: true,
            isbackarrow: false,
          ),

          
        ],
      ),
      bottomNavigationBar: Container(
        height: 100.0,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.only(topRight: Radius.circular(8.0),topLeft: Radius.circular(8.0)),
        ),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 7.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 15.0,left: 14.0,right: 14.0),
                    child: Text(
                      'Checkout',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 17.0,
                          fontWeight: FontWeight.w600
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 13.0,left: 14.0,right: 14.0),
                    child: Text(
                      '\$${_subTotal}',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.5),
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600,

                      ),
                    ),
                  )
                ],
              ),

              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) =>
                      Payment(amount: _subTotal,OrderId: user.uid,email: user.email,),
                  ));
                },
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      for(int i=0;i<8;i++)
                        Icon(
                          Icons.chevron_right,
                          color: Colors.white,
                          size: 20.0,
                        ),
                    ],
                  ),
                ),
              )

            ],
          ),
        ),
      ),
    );
  }
}
