import 'package:a_commerce/components/product_card.dart';
import 'package:a_commerce/components/textfield.dart';
import 'package:a_commerce/screens/product_page.dart';
import 'package:a_commerce/services/firebase_services.dart';
import 'package:a_commerce/utilites/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SearchTab extends StatefulWidget {
  @override
  _SearchTabState createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  FirebaseServices _firebaseServices = FirebaseServices();

  String _searchString = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          if (_searchString.isEmpty)
            Center(
              child: Container(
                child: Text(
                  "Search Results",
                  style: kheadstyle,
                ),
              ),
            )
          else
            FutureBuilder<QuerySnapshot>(
              future: _firebaseServices.productsRef
                  .orderBy('search_string')
                  .startAt([_searchString]).endAt(['${_searchString}\uf8ff']).get(),
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
          Padding(
            padding: const EdgeInsets.only(top: 50.0),
            child: mytextfield(
              hinttext: 'Search here.....',
              textchange: (value) {
                setState(() {
                  _searchString = value.toLowerCase();
                });
              },
            ),
          ),
          // Text('Search Results',style: kheadstyle,),
        ],
      ),
    );
  }
}
