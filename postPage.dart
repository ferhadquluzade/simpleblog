import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
 
class PostPage extends StatefulWidget {
  @override
  _PostPageState createState() => _PostPageState();
}
 
class _PostPageState extends State<PostPage> {
  TextEditingController t1 = TextEditingController();
  TextEditingController t2 = TextEditingController();
 
  var comingDataValue = "";
  var comingDataTitle = "";
 
  FirebaseAuth auth = FirebaseAuth.instance;
 
 add() {
    FirebaseFirestore.instance.collection("Posts").doc(t1.text).set({
      'UserId': auth.currentUser.uid,
      'Title': t1.text,
      'Value': t2.text
    });
  }
 
 update() {
    FirebaseFirestore.instance
        .collection("Posts")
        .doc(t1.text)
        .update({'Title': t1.text, 'Value': t2.text});
  }
 
  delete() {
    FirebaseFirestore.instance.collection("Posts").doc(t1.text).delete();
  }

 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Container(
        margin: EdgeInsets.all(40),
        child: Center(
          child: Column(
            children: [
              TextField(
                controller: t1,
              ),
              TextField(
                controller: t2,
              ),
              Column(
                children: [
                  RaisedButton(child: Text("Add"), onPressed: add),
                  RaisedButton(child: Text("Update"), onPressed: update),
                  RaisedButton(child: Text("Del"), onPressed: delete),
                ],
              ),
              ListTile(
                title: Text(comingDataValue),
                subtitle: Text(comingDataTitle),
              ),
            ],
          ),
        ),
      ),
    );
  }
}