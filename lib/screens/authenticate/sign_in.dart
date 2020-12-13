import 'package:brew_crew/services/auth.dart';
import 'package:brew_crew/shared/constants.dart';
import 'package:brew_crew/shared/loading.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  //now we need to make constructor to accept toggleView as a param
  //constructor needs to be in the widget and not below(which is an object)
  final Function toggleView;
  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  //creating instance of AuthService class to access signInAnon function
  final AuthService _auth =
      AuthService(); //name auth doesn't have to be same; _ denotes it can be only used over here

  //we don't want to keep any values empty, so we will use some flutter built-in validation features
  final _formKey =
      GlobalKey<FormState>(); //identify the key for this form as _formkey
  //_formKey is the global key and we are going to use this key to identify our form
  //associate our form with this global form state key

  bool loading =
      false; //by default it is false, if it becomes true, then we will show the loading widget
  //text field state
  String email = '';
  String password = '';
  String error = '';
  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.brown[100],
            appBar: AppBar(
              backgroundColor: Colors.brown[400],
              elevation: 0.0,
              title: Text('Sign in to Café Coffee Day',
                  style: TextStyle(fontSize: 18.0)),
              //toggle between register and sign in
              actions: [
                FlatButton.icon(
                  icon: Icon(Icons.person),
                  label: Text('Register'),
                  onPressed: () {
                    widget.toggleView(); //widget refers to signIn widget
                  },
                )
              ],
            ),
            body: Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
              /*
        child: RaisedButton(
          child: Text('Sign in anon'),
          onPressed: () async {
            dynamic result = await _auth
                .signInAnon(); //using await since signInAnon return type is future
            if (result == null) {
              print('error signing in');
            } else {
              print('signed in');
              //print(result);
              print(result.uid);
            }
          },
        ),
        */
              //now making email sign in method
              child: Form(
                  key: _formKey, //will keep track of the state of our form
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20.0,
                      ),
                      TextFormField(
                        decoration:
                            textInputDecoration.copyWith(hintText: 'Email'),
                        //validator properties allow us to run a function, to see if the form field is valid or not
                        //validator is a function which takes val as param
                        //if it returns null, then it is non-empty
                        validator: (val) =>
                            val.isEmpty ? 'Enter an email' : null,
                        onChanged: (val) {
                          //what happens when this field is changed(i.e. after the user types anything extra,
                          //or presses the delete key or space key) is decided by onchanged property
                          //val represents whatever is in the form field at that point
                          setState(() => email =
                              val); //setting email with the current value
                        },
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      TextFormField(
                        decoration:
                            textInputDecoration.copyWith(hintText: 'Password'),
                        validator: (val) => val.length < 6
                            ? 'Enter a password 6+ chars long'
                            : null,
                        obscureText: true, //for passwords
                        onChanged: (val) {
                          setState(() => password = val);
                        },
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      RaisedButton(
                        color: Colors.pink[400],
                        child: Text(
                          'Sign in',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () async {
                          //when we run this validate function and it checks each validator
                          //if all the validators return null, then this condition will be true
                          if (_formKey.currentState.validate()) {
                            //after clicking, loading screen should appear,so make it true
                            setState(() => loading = true);
                            dynamic result = await _auth
                                .signInWithEmailAndPassword(email, password);
                            if (result == null) {
                              setState(() {
                                error =
                                    'could not sign in with the those credentials';
                                //if we get an error, make loading false to show the error
                                loading = false;
                              });
                            }
                          }
                        },
                      ),
                      SizedBox(height: 20.0),
                      Text(
                        error,
                        style: TextStyle(color: Colors.red, fontSize: 14.0),
                      ),
                    ],
                  )),
            ),
          );
  }
}
