import 'package:brew_crew/models/user.dart';
import 'package:brew_crew/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  //create instance of firebase auth, and this instance will allow us to communicate
  //with the firebase at the backend

  final FirebaseAuth _auth = FirebaseAuth.instance;
  //final means won't change in future
  //FirebaseAuth is the type and we created its object named _auth
  //underscore on auth means: it is private(cannot use anywhere else)

  //function which creates user object based on FirebaseUser
  User _userFromFirebaseUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }

  //stream which detects authentication changes
  /*
  Stream<FirebaseUser> get user {
    //datatype within the angular brackets: is the return type of the stream
    return _auth
        .onAuthStateChanged; //whenever there is an auth change, this stream will return a firebaseuser object
  }
  */

  //we don't want to work with firebaseuser, but want to work with custom user
  Stream<User> get user {
    //get user : the variable can have any name(other than user as well)
    //map it stream of users based on user class
    return _auth.onAuthStateChanged
        //.map((FirebaseUser user) => _userFromFirebaseUser(user));
        //in bracket is the function(FirebaseUser user) and the second thing is return type
        .map(_userFromFirebaseUser);
    //this is same as above map line(another way to write)
  }

  //sign in anonmously->async task(will return a future)
  Future signInAnon() async {
    try {
      AuthResult result = await _auth
          .signInAnonymously(); //signinAnonymously returns an Authresult object
      FirebaseUser user = result.user;
      //return user;  //now we will return custom user id instead of firebase user object
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //sign in with email & password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          //builitin function
          email: email,
          password: password);
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //register with email & password
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          //builitin function
          email: email,
          password: password);
      FirebaseUser user = result.user;

      //create a new document for the user with the uid; over here firebase uid used
      await DatabaseService(uid: user.uid)
          .updateUserData('0', 'new member', 100);
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //sign out
  Future signOut() async {
    //the name of the func(signOut) over here can be any other name aswell
    try {
      return await _auth
          .signOut(); //but this signOut is not name but a property
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
