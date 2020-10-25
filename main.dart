import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'profilePage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Authentication(),
    );
  }
}

class Authentication extends StatefulWidget {
  @override
  _AuthenticationState createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {
  TextEditingController t1 = TextEditingController();
  TextEditingController t2 = TextEditingController();

  Future<void> signUp() async {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: t1.text, password: t2.text)
        .then((kullanici) {
      FirebaseFirestore.instance
          .collection("Users")
          .doc(t1.text)
          .set({"Email": t1.text, "Password": t2.text});
    });
  }

  signIn() {
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: t1.text, password: t2.text)
        .then((kullanici) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => ProfilePage()),
          (Route<dynamic> route) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration:BoxDecoration(
        image:DecorationImage(
          image:AssetImage("images/k.jpg"),
          fit:BoxFit.cover
        ),
        ),
        
          child: Container(
            margin:EdgeInsets.all(40),
            child: Column(
              children: [
                Card(
                                  child: TextFormField(
                    controller: t1,
                    decoration: const InputDecoration(
                      labelText: 'Email',

                      )
                    ),
                ),
            
                
                Card(
                                  child: TextFormField(
                    controller: t2,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                    ),
                    
                  ),
                ),
                SizedBox(height: 40),
                RaisedButton(child: Text("Sign Up"), onPressed: signUp),
                Divider(
                  height: 20,
                  thickness: 5,
                  indent: 20,
                  endIndent: 20,
                ),
                RaisedButton(child: Text("Sign In"), onPressed: signIn),
              ],
            ),
          ),
        
      ),
    );
  }
}
