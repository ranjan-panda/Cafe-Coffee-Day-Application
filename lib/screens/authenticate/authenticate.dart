import 'package:brew_crew/screens/authenticate/register.dart';
import 'package:brew_crew/screens/authenticate/sign_in.dart';
import 'package:flutter/material.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}
//this authenticate is the wrapper for signin and register
//so we can a have a state, if true show one screen and false then the other

class _AuthenticateState extends State<Authenticate> {
  bool showSignIn = true;

  //function to toggle it b/w true to false and vice versa
  void toggleView() {
    setState(() =>
        showSignIn = !showSignIn); //toggles it from what it is to the other one
  }

  //we want to call this func from both register and signin form when we click their respective buttons
  //so we have to send this func as a parameter in the below if else code
  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
      return SignIn(toggleView: toggleView);
      //parameter name(the one on the left) can be anything(can be toggleView as well)
      //but its value(the toggleView on the right) needs to be the above defined function
    } else {
      return Register(toggleView: toggleView);
    }
  }
}
