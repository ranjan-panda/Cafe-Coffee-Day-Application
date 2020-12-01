import 'package:brew_crew/models/user.dart';
import 'package:brew_crew/screens/authenticate/authenticate.dart';
import 'package:brew_crew/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //user is just the name of variable (can use any)
    final user =
        Provider.of<User>(context); //accessing the data from the provider
    //in angular brackets-> the datatype we need
    //print(user);
    /* null is printed first when there is no user
                  then instance of user, since we have one async user*/

    //return either home or authenticate widgget
    if (user == null) {
      return Authenticate();
    } else {
      return Home();
    }
  }
}
