import 'package:a_commerce/components/custom_actionBar.dart';
import 'package:a_commerce/components/product_card.dart';
import 'package:a_commerce/screens/product_page.dart';
import 'package:a_commerce/services/firebase_services.dart';
import 'package:a_commerce/utilites/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomeTab extends StatelessWidget {
  FirebaseServices _firebaseServices = FirebaseServices();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          FutureBuilder<QuerySnapshot>(
            future: _firebaseServices.productsRef.get(),
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
                  padding: EdgeInsets.only(top: 108.0, bottom: 24.0),
                  children: snapshot.data.docs.map((document) {
                    return ProductCard(
                      title: (document).data()['name'],
                      imageUrl: (document).data()['images'][1],
                      price: '${(document).data()['price']}',
                      onPress: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    ProductPage(id: document.id)));
                      },
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
            title: 'HOME',
            pgno: 0,
            hasbackarrow: true,
            hasTitle: true,
            isbackarrow: true,
          )
        ],
      ),
    );
  }
}

// class ProductCard extends StatelessWidget {
//   const ProductCard({
//     Key key,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: (){
//         Navigator.push(context, MaterialPageRoute(builder: (context) => ProductPage(id: document.id)));
//       },
//       child: Container(
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(12.0)
//         ),
//         height: 300.0,
//         margin: EdgeInsets.symmetric(
//             vertical: 12.0, horizontal: 24.0),
//         child: Stack(
//           children: [
//             Container(
//               height: 300.0,
//               child: ClipRRect(
//                 child: Image.network(
//                   '${(document).data()['images'][1]}',
//                   fit: BoxFit.cover,
//                 ),
//                 borderRadius: BorderRadius.circular(12.0),
//               ),
//             ),
//             Positioned(
//               bottom: 0,
//               left: 0,
//               right: 0,
//               child: Padding(
//                 padding: const EdgeInsets.all(20.0),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text('${(document).data()['name']} ' ?? 'Product name',style: kdescriptionstyle,),
//                     Text('\$${(document).data()['price']}' ?? 'Price',style: TextStyle(color: Theme.of(context).accentColor,fontSize: 16.0,fontWeight: FontWeight.w600),),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
