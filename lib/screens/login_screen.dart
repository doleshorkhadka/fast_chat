// ignore_for_file: prefer_const_constructors

import 'package:fast_chat/components/rounded_button.dart';
import 'package:fast_chat/constants.dart';
import 'package:fast_chat/screens/chat_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String? email;
  String? password;
  User? user;
  final _auth = FirebaseAuth.instance;
  bool _isSpinning = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: _isSpinning,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible(
                child: Hero(
                  tag: 'logo',
                  child: SizedBox(
                    height: 200.0,
                    child: Image.asset('images/logo.png'),
                  ),
                ),
              ),
              SizedBox(
                height: 48.0,
              ),
              TextField(
                textAlign: TextAlign.center,
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) {
                  email = value;
                },
                decoration:
                    kInputDecoration.copyWith(hintText: 'Enter your email'),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                textAlign: TextAlign.center,
                obscureText: true,
                onChanged: (value) {
                  password = value;
                },
                decoration: kInputDecoration.copyWith(
                  hintText: 'Enter your password',
                ),
              ),
              SizedBox(
                height: 24.0,
              ),
              RoundedButton(
                text: 'Log In',
                color: Colors.lightBlueAccent,
                onPress: () async {
                  try {
                    if (email != null && password != null) {
                      setState(() {
                        _isSpinning = true;
                      });
                      await _auth.signInWithEmailAndPassword(
                        email: email.toString(),
                        password: password.toString(),
                      );
                      setState(() {
                        _isSpinning = false;
                      });
                      Navigator.pushNamed(context, ChatScreen.id);
                    }
                  } catch (e) {
                    setState(() {
                      _isSpinning = false;
                    });
                    print('Error logging in....');
                    print(e);
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
