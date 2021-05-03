import 'package:a_commerce/components/custom_actionBar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UploadProduct extends StatefulWidget {
  @override
  _UploadProductState createState() => _UploadProductState();
}

class _UploadProductState extends State<UploadProduct> {
  TextEditingController nameController = new TextEditingController();
  TextEditingController descController = new TextEditingController();
  TextEditingController priceController = new TextEditingController();
  TextEditingController imgController = new TextEditingController();
  TextEditingController sizeController = new TextEditingController();

  Map<String, dynamic> addToFirebase;

  CollectionReference collectionReference =
      FirebaseFirestore.instance.collection('Products');

  _buildTextField(TextEditingController controller, String labelText) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Theme.of(context).accentColor, width: 6),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.7),
              offset: Offset(0, 12),
              spreadRadius: 3.0,
              blurRadius: 10.0,
            ),
          ]),
      child: TextField(
        controller: controller,
        style: TextStyle(color: Colors.black),
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 10),
            labelText: labelText,
            labelStyle: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.w600),
            // prefix: Icon(icon),
            border: InputBorder.none),
      ),
    );
  }

  addProduct() {
    addToFirebase = {
      'name': nameController.value.text,
      'desc': descController.value.text,
      'price': priceController.value.text,
      'image': imgController.value.text,
    };

    collectionReference
        .add(addToFirebase)
        .whenComplete(() => print('Added to firebase'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CustomActionBar(
            title: 'Add Product',
            hasTitle: true,
            hasbackarrow: true,
            hasbackground: true,
            isbackarrow: false,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              children: [
                SizedBox(
                  height: 30,
                ),
                _buildTextField(nameController, 'Name'),
                SizedBox(
                  height: 20,
                ),
                _buildTextField(descController, 'Description'),
                SizedBox(
                  height: 20,
                ),
                _buildTextField(priceController, 'Price'),
                SizedBox(
                  height: 20,
                ),
                _buildTextField(imgController, 'Image'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
