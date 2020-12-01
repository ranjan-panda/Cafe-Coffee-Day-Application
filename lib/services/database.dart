import 'package:brew_crew/models/brew.dart';
import 'package:brew_crew/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

//we will define various methods in this class to interact with the database
class DatabaseService {
  final String uid;
  DatabaseService({this.uid});
  //collection reference - reference to a collection in DB
  final CollectionReference brewCollection = Firestore.instance
      .collection('brews'); //we are naming our collection as brews
  //it doesn't matter if we have created the collection or not
  //If not,it will get created and brewCollection will then get the reference

  //the below function will be used twice: once they sign up and once they need to update it
  Future updateUserData(String sugars, String name, int strength) async {
    //at sign up the document for the uid does not exist
    //so firebase will create the document for the uid
    return await brewCollection.document(uid).setData({
      'sugars': sugars,
      'name': name,
      'strength': strength,
    });
    //data within setData is map(key value pairs)
  }

  //function to make brew_list from snapshot
  List<Brew> _brewListFromSnapsot(QuerySnapshot snapshot) {
    //the map method is cycling through the list of documents and then for each document we return a brew
    return snapshot.documents.map((doc) {
      //we are referring to each document as doc
      return Brew(
          //doc.data gets the data object; now doc.data is a map and its value can
          //be accessed by doc.data['key']
          name: doc.data['name'] ?? '', //if null then return empty string
          strength: doc.data['strength'] ?? 0,
          sugars: doc.data['sugars'] ?? '0');
    }).toList(); //since map(()) <- returns an iterable : convert to list
  }

  //function to convert documentsnapshot and turn it into userdata object
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    //return new UserData object
    return UserData(
        uid: uid,
        name: snapshot.data['name'],
        sugars: snapshot.data['sugars'],
        strength: snapshot.data['strength']);
  }

  //Set another stream, which will notify of document changes
  //Data we get from the stream is a snapshot of brews data collection at that moment
  //The snapshot is basically an object of the current document containing properties and values
  /*
  Stream<QuerySnapshot> get brews {
    //get brews : variable name can be any name, other than brews as well
    return brewCollection.snapshots();

  }
  */
  //now its returning list of brews
  Stream<List<Brew>> get brews {
    return brewCollection.snapshots().map(_brewListFromSnapsot);
  }

  /*
  //get user document stream
  Stream<DocumentSnapshot> get userData {
    return brewCollection.document(uid).snapshots();
    //when we create an instance of this class to use this stream later on, we will pass on uid with it
    //we will receive snapshots everytime it changes and also when the app first loads
  }
  */

  Stream<UserData> get userData {
    return brewCollection.document(uid).snapshots().map(_userDataFromSnapshot);
    //mapping it into a stream tha returns UserData object
  }
}
