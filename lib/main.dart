import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


void main() => runApp(NewApp());

class NewApp extends StatelessWidget {
 @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Test"),
        ),
        body: GetData(),
      ),
    );
  }
}

class GetData extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('posts').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError)
          return new Text('Error: ${snapshot.error}');
        switch (snapshot.connectionState) {
          case ConnectionState.waiting: return new Text('Loading...');
          default:
            return new ListView(
              children: snapshot.data.documents.map((DocumentSnapshot document) {
                return new ListTile(
                  title: new Text(document['Name']),
                  subtitle: new Text(document['Description']),
                );
              }).toList(),
            );
        }
      },
    );
  }
}