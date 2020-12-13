import 'package:brew_crew/models/user.dart';
import 'package:brew_crew/services/database.dart';
import 'package:brew_crew/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:brew_crew/shared/constants.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> sugars = ['0', '1', '2', '3', '4'];

  //form values
  String _currentName;
  String _currentSugars;
  int _currentStrength;
  @override
  Widget build(BuildContext context) {
    //we can get the uid via the provider in wrapper.dart
    final user = Provider.of<User>(context);
    //right click on form and wrap with StreamBuilder
    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid)
            .userData, //userData is the stream name
        //we are passing the id that matches the current id of the logged in user
        builder: (context, snapshot) {
          //data which comes down the stream, is referred as snapshot over here
          //we check if we have data on this snapshot, before we move on doing sth in the widget
          if (snapshot.hasData) {
            UserData userData = snapshot.data;
            return Form(
                key: _formKey,
                //several form fields will be there; stacked on one another
                child: Column(
                  children: [
                    Text(
                      'Update your coffee preference',
                      style: TextStyle(fontSize: 18.0),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    TextFormField(
                      //after setting up the stream builder we can now have an initialValue
                      initialValue: userData.name,
                      //using the same decoration used earlier
                      decoration: textInputDecoration,
                      validator: (val) =>
                          val.isEmpty ? 'Please enter a name' : null,
                      onChanged: (val) => setState(() => _currentName = val),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),

                    //dropdown
                    DropdownButtonFormField(
                        decoration: textInputDecoration,
                        //the value of the dropdownbutton itself
                        // value: _currentSugars ?? '0',
                        // //if currentSugars not selected then value is '0'
                        //changing initial fallback value from '0' to whatever is stored in firebase document
                        value: _currentSugars ?? userData.sugars,
                        //the values of items should be list of drop down menu items
                        items: sugars.map((sugar) {
                          return DropdownMenuItem(
                            //this value tracks the value of the item that gets selected
                            value: sugar,
                            //the child is what will be shown in drop-down
                            child: Text('$sugar sugars'),
                          );
                        }).toList(),
                        //after selecting from dropdown, to show up the value, include below onchanged
                        onChanged: (val) => setState(() => _currentSugars = val)
                        //val is the second value
                        ),

                    //slider
                    Slider(
                      //the slider works with double, hence necessary typecasting
                      /*
                       value: (_currentStrength ?? 100).toDouble(),
                      //if null then assign to 100
                      activeColor: Colors
                          .brown[_currentStrength ?? 100], //color to the left
                      inactiveColor: Colors
                          .brown[_currentStrength ?? 100], //all to the right
                      */
                      //instead of defaulting to 100, we do below
                      value: (_currentStrength ?? userData.strength).toDouble(),
                      activeColor: Colors.brown[_currentStrength ??
                          userData.strength], //color to the left
                      inactiveColor: Colors.brown[_currentStrength ??
                          userData.strength], //all to the right

                      min: 100.0,
                      max: 900.0,
                      divisions:
                          8, //from 1 to 2, 2 to 3,...,8 to 9; total 8 divisions
                      onChanged: (val) => setState(() => _currentStrength =
                          val.round()), //typecasting val to integer
                    ),
                    //button at the bottom
                    RaisedButton(
                        color: Colors.pink[400],
                        child: Text(
                          'Update',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () async {
                          //perforing form validation
                          if (_formKey.currentState.validate()) {
                            //if it is valid, it will return true
                            await DatabaseService(uid: user.uid).updateUserData(
                                _currentSugars ?? userData.sugars,
                                //if we don't update and press submit, then instead of
                                //saving null in DB, it will store the old value
                                _currentName ?? userData.name,
                                _currentStrength ?? userData.strength);
                          }
                          //after the form stuff is done, shut the bottomsheet
                          Navigator.pop(context);
                          // print(_currentName);
                          // print(_currentSugars);
                          // print(_currentStrength);
                        }),
                  ],
                ));
          } else {
            //if it doesn't have data, it will show the loading screen
            return Loading();
          }
        });
  }
}
