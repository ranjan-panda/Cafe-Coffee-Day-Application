//created this class to control what property our user should have in our user class
class User {
  //property which wont change as user goes b/w diff screens
  final String uid;

  User({this.uid});
}

class UserData {
  final String uid;
  final String name;
  final String sugars;
  final int strength;

  UserData({this.uid, this.sugars, this.name, this.strength});
  //very similar to brew model(except the uid is new added property), we could have used brew model itself
  //but made another one, since we can extend one model independent of the other
}
