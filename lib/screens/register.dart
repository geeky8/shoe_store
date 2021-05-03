import 'package:a_commerce/components/lite_buttons.dart';
import 'package:a_commerce/components/textfield.dart';
import 'package:a_commerce/utilites/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  //future dialog box to display any error
  Future<void> _alertBuilder(String e) async {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('ERROR'),
            content: Container(
              child: Text(e),
            ),
            actions: [
              FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Exit'))
            ],
          );
        });
  }

  //create new user account
  Future<String> _createAccount() async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        return 'The account already exists for that email.';
      } else {
        return e.message;
      }
    } catch (e) {
      return e;
    }
  }

  void submitForm()async{
    setState(() {
      registerLoading = true;
    });
    //run the create account method
    String _createAccountfeedback = await _createAccount();
    //if the form  is not null we got an error
    if(_createAccountfeedback != null){
      _alertBuilder(_createAccountfeedback);
      // set the form to original state i.e not loading
      setState(() {
        registerLoading = false;
      });
    }
    else{
      //as the string was null user is logged in
      Navigator.pop(context);
    }

  }

  //default form loading state
  bool registerLoading = false;

  //form inputfield values
  String email = '';
  String password = '';

  //focus node for password
  FocusNode _registerFocus;

  final control1 = TextEditingController();
  final control2 = TextEditingController();

  @override
  void initState() {
    _registerFocus = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _registerFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.only(top: 20.0),
                child: Text(
                  'Create a new account',
                  textAlign: TextAlign.center,
                  style: kBoldheadstyle,
                ),
              ),
              Column(
                children: [
                  mytextfield(
                    hinttext: 'email....',
                    pass: false,
                    textchange: (value) {
                      email = value;
                    },
                    control: control1,
                    onSubmit: (value) {
                      _registerFocus.requestFocus();
                    },
                    textInputAction: TextInputAction.next,
                  ),
                  mytextfield(
                    hinttext: 'password....',
                    pass: true,
                    textchange: (value) {
                      password = value;
                    },
                    control: control2,
                    focusNode: _registerFocus,
                    onSubmit: (value){
                      submitForm();
                      FocusScope.of(context).requestFocus(FocusNode());
                    },
                  ),
                  LiteButton(
                    text: 'Create Account',
                    onpressed: () {
                      submitForm();
                      print(email);
                      print(password);
                      control1.clear();
                      control2.clear();
                    },
                    but: false,
                    isLoading: registerLoading,
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: LiteButton(
                  text: 'Back to Login',
                  onpressed: () {
                    Navigator.pushNamed(context, 'login');
                  },
                  but: true,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
