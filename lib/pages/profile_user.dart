import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:visit_me/pages/PlaceView.dart';
import 'package:visit_me/pages/favorite_page.dart';
import 'package:visit_me/pages/login_page.dart';
final ListBox = GetStorage();

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
     ListBox.write('IsUserval', false);
  }

  @override
  Widget build(BuildContext context) {
    _LogCardState().getCurrentUser();
   return Scaffold(
       extendBodyBehindAppBar: true,
        appBar: AppBar(
            title: const Text("VISIT-ME"),
            backgroundColor: Colors.teal.shade50,
            elevation: 0,
            centerTitle:true
        ),
        body:
          FutureBuilder<Map<dynamic, dynamic>>(
          future:getCurrentUser(),
          builder: (BuildContext context, AsyncSnapshot <Map<dynamic, dynamic>>snapshot){
            Map? Mainuser = snapshot.data;
          if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
          } else if (snapshot.error != null) {
          return const Center(child: Text('an error occured!'));
          } else{

            final ico = Mainuser!['name']?.substring(0, 1); // extractor de inicial
            int l = Mainuser['fav'].length;
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Container(height: 25,
                    child: Text(Mainuser['name'], textAlign: TextAlign.center,textScaleFactor: 1.25,),)],),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Container(height:20,
                    child: Text(Mainuser['email'], textAlign: TextAlign.center,textScaleFactor: .9,),)],),
                // favirtos cargados en firebase al arrancar.
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:[Container(
                      height: 40,
                      child:
                       TextButton(
                      child: const Text('logout'),
                      onPressed: () {
                      _LogCardState().sendout();
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));

                      }, // <- aquí va el llamado a la función logout
                    )),
                  ],
                ),
                Row(children: [Container(height: 50,)],),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Container(height: 25,
                    child: Text("favoritos", textAlign: TextAlign.center,textScaleFactor: 1.25,),)],),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Container(height:20,
                    child: Text("tus favoritos: $l", textAlign: TextAlign.center,textScaleFactor: .9,),)],),
                // favirtos cargados en firebase al arrancar.
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    TextButton(
                      child: const Text('restauar'),
                      onPressed: () {
                        FavBottomvState().getFire();
                      }, // <- aquí va el llamado a la función logout
                    ),
                  ],
                ),
                Row(children: [Container(height: 150,)],),
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

