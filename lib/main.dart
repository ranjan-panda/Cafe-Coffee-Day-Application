import 'package:brew_crew/models/user.dart';
import 'package:brew_crew/screens/wrapper.dart';
import 'package:brew_crew/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    /* the way the provider package works is, wrap a widget tree in a provider(over here materialapp)
       and now supply a stream to the provider by auth change stream, then whenever
       we get new data in that stream, the provider makes it available for all
       widgets under it.
       Firebase Auth Change Stream sends null at logout and user object at sign in
       based on that we show home or sign in at wrapper stage
       */

    return StreamProvider<User>.value(
      //in angular brackets the data we will listen
      //StreamProvider is a prvoider
      //value is the stream we want to listen and the data we expect

      //when we created user stream we called it user
      //so here we are creating an instance of AuthService and accessing the user stream
      value: AuthService().user,
      child: MaterialApp(
        //assigning wrapper as the home screen
        home: Wrapper(),
      ),
    );
  }
}
