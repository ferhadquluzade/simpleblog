import 'package:cloud_firestore/cloud_firestore.dart';
import "package:flutter/material.dart";
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:Text("Discover")),
      body: Container(
        child: AllPosts(),
      ),
    );
  }
}
 
class AllPosts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FirebaseFirestore auth = FirebaseFirestore.instance;
 
    Query posts = auth.collection('Posts');
     
    return StreamBuilder<QuerySnapshot>(
      stream: posts.snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }
 
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }
 
        return new ListView(
          children: snapshot.data.docs.map((DocumentSnapshot document) {
            return new ListTile(
              title: new Text(document.data()['Title']),
              subtitle: new Text(document.data()['Value']),
            );
          }).toList(),
        );
      },
    );
  }
}