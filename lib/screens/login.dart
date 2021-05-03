import 'package:a_commerce/components/lite_buttons.dart';
import 'package:a_commerce/screens/homepage.dart';
import 'package:a_commerce/components/textfield.dart';
import 'package:a_commerce/utilites/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

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

  Future<String> _LoginAccount() async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
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
      loginLoading = true;
    });
    //run the create account method
    String _Loginfeedback = await _LoginAccount();
    //if the form  is not null we got an error
    if(_Loginfeedback != null){
      _alertBuilder(_Loginfeedback);
      // set the form to original state i.e not loading
      setState(() {
        loginLoading = false;
      });
    }
  }

  bool loginLoading = false;

  String email = '';
  String password = '';

  FocusNode _loginFocus;

  final control1 = TextEditingController();
  final control2 = TextEditingController();

  @override
  void initState() {
    _loginFocus = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _loginFocus.dispose();
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
                  'Welcome user,\nLogin to your account',
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
                    onSubmit: (value){
                      _loginFocus.requestFocus();
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
                    onSubmit: (value){
                      submitForm();
                      FocusScope.of(context).requestFocus(FocusNode());
                    },
                  ),
                  LiteButton(
                    text: 'Login',
                    onpressed: () {
                      submitForm();
                      print(email);
                      print(password);
                      control1.clear();
                      control2.clear();
                    },
                    but: false,
                    isLoading: loginLoading,
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: LiteButton(
                  text: 'Create Account',
                  onpressed: () {
                    Navigator.pushNamed(context, 'register');
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
