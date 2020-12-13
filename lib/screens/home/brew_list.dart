//responsible for outputting different brews
import 'package:brew_crew/models/brew.dart';
import 'package:brew_crew/screens/home/brew_tile.dart';
import 'package:flutter/material.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

class BrewList extends StatefulWidget {
  @override
  _BrewListState createState() => _BrewListState();
}

class _BrewListState extends State<BrewList> {
  @override
  Widget build(BuildContext context) {
    //accessing data from stream
    //final brews = Provider.of<QuerySnapshot>(context);

    // //print(brews.documents);//will show all the documents in the collection
    // for (var doc in brews.documents) {
    //   print(doc.data);
    // }

    //accessing brews instead of snapshots(which is the form of data for firebase)
    final brews = Provider.of<List<Brew>>(context) ?? [];
    //if they don't exist from the very start, then return the empty list(else will show small error)

    /*
    brews.forEach((brew) {
      print(brew.name);
      print(brew.sugars);
      print(brew.strength);
    });
    */

    return ListView.builder(
      itemCount: brews.length,
      itemBuilder: (context, index) {
        //return a widget for each item in brews list
        return BrewTile(brew: brews[index]);
        //keeping it modular and defining this widget somewhere else
      },
    );
  }
}
/*now instead of getting snapshot and showing its data, we will create our 
own brew model. When we receive query snapshot,we convert it to brew object */
