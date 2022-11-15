import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:visit_me/pages/login_page.dart';
import 'package:visit_me/pages/favorite_page.dart';

class LogCard extends StatefulWidget {
  const LogCard({Key? key}) : super(key: key);
  @override
  State<LogCard> createState() => _LogCardState();
}

class _LogCardState extends State<LogCard> {
  bool shadowColor = false;

  FirebaseFirestore db  = FirebaseFirestore.instance;
  Future<Map<dynamic, dynamic>> getCurrentUser() async {
    final docRef = db.collection("users").doc(FirebaseAuth.instance.currentUser?.uid);
    DocumentSnapshot doc = await docRef.get();
    final data = doc.data() as Map;
    return data;
  }



   void sendout() async {
     FavPageState().setFire();
     SharedPreferences prefs = await SharedPreferences.getInstance();
     await prefs.setBool('setUserVal', false);
     final bool? UserVal = prefs.getBool('setUserVal');
     print(UserVal);

  }

  @override
  Widget build(BuildContext context) {
    _LogCardState().getCurrentUser();
   return Scaffold(
        appBar: AppBar(
            title: const Text("VISIT-ME"),
            backgroundColor: Colors.white12,
            elevation: 0,
            centerTitle:true
        ),
        body:
          FutureBuilder<Map<dynamic, dynamic>>(
          future:getCurrentUser(),
          builder: (BuildContext context, AsyncSnapshot <Map<dynamic, dynamic>>snapshot){
            Map? Mainuser = snapshot.data;
            final numFav= Mainuser!['fav'].length;
            if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
          } else if (snapshot.error != null) {
          return const Center(child: Text('an error occured!'));
          } else{

            final ico = Mainuser!['name']?.substring(0, 1); // extractor de inicial

            // numero de fav en firebase
            return Center(
        child: ListView.builder(
        itemCount: 1,
        itemBuilder: (context, index) {
         return Card(
            child:  Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Row(children: [Container(height: 50,)],),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[  CircleAvatar(
                      backgroundColor: Colors.green,
                      radius: 115,
                      child: CircleAvatar(
                        backgroundColor: Colors.teal.shade50,
                        radius: 110,
                        child: CircleAvatar(backgroundColor: Color(0xFFB2DFDB),
                            child: Text(ico, style: TextStyle(fontSize: 100, color: Colors.white)),
                            radius: 100), //CircleAvatar
                      ), //CircleAvatar
                    ), //CircleAvatar
                    ]),
                Row(children: [Container(height: 50,)],),
                ListTile(
                  title: Text(Mainuser['name'], textAlign: TextAlign.center,),
                  subtitle: Text(Mainuser['email'], textAlign: TextAlign.center,),
                 //leading: CircleAvatar
                    // (backgroundColor: Color(0xFFB2DFDB),child: Text(ico), radius: 30.0,),//trailing: Icon(Icons.favorite_border)
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Container(height: 20,
                    child: Text("favoritos: $numFav", textAlign: TextAlign.center,),)],),
                // favirtos cargados en firebase al arrancar.
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    TextButton(
                      child: const Text('logout'),
                      onPressed: () {
                      _LogCardState().sendout();
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));

                      }, // <- aquí va el llamado a la función logout
                    ),
                  ],
                ),
              ],
            ),
          );
        }
        )
        );
          }
          }
          ) //<-
        );
      }
    }

