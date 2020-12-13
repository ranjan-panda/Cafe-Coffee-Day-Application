import 'package:brew_crew/models/brew.dart';
import 'package:brew_crew/screens/home/brew_list.dart';
import 'package:brew_crew/screens/home/settings_form.dart';
import 'package:brew_crew/services/auth.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
//now we no longer need QuerySnapshot so we can remove above include
import 'package:flutter/material.dart';
import 'package:brew_crew/services/database.dart';
import 'package:provider/provider.dart';

//stateless widget ->not going to directly use state over here
class Home extends StatelessWidget {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    //building the function over here, since we need 'context' in it
    void _showSettingsPanel() {
      //showModalBottomSheet: builtin function to show bottom sheet
      //builder returns the widget/template which is there in bottomSheet
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
              child: SettingsForm(),
            );
          });
    }

    //return StreamProvider<QuerySnapshot>.value(
    //now we are calling our own List of Brew model instead of snapshot
    return StreamProvider<List<Brew>>.value(
      value: DatabaseService().brews,
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          title: Text('CCd'),
          backgroundColor: Colors.brown[400],
          elevation: 0.0,
          //actions expect a widget list and they are gonna appear at right of appbar
          actions: [
            FlatButton.icon(
              icon: Icon(Icons.person),
              label: Text('logout'),
              onPressed: () async {
                await _auth.signOut(); //we dont need to set this value to some
                //result, we just need to wait and when
                //this is completed, user value in wrapper
                //updates to null and shows authenticate screen
              },
            ),
            //another flatbutton to show up form
            FlatButton.icon(
              icon: Icon(Icons.settings),
              label: Text('settings'),
              onPressed: () => _showSettingsPanel(),
            )
          ],
        ),
        //right click BrewList and wrap with container
        body: Container(
            //this decoration widget part was told in flutter beginner part
            decoration: BoxDecoration(
                image: DecorationImage(
              image: AssetImage('assets/coffee_bg.png'),
              fit: BoxFit.cover,
            )),
            child: BrewList()),
      ),
    );
  }
}
