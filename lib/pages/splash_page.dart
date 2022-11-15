import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:visit_me/pages/list_poi.dart';
import 'package:visit_me/pages/login_page.dart';
import 'package:visit_me/pages/tab_page.dart';


class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  List listTitles = [];
  List listUrl = [];

  //Inicializar la función _closeSplash
  void initState(){
     getPlace();
    _closeSplash();
    super.initState();
  }


  Future<Map> getPlace() async { // funcion para carga la informacion de firestore

    @override
    CollectionReference _collectionRef =
    FirebaseFirestore.instance.collection('place');
    QuerySnapshot querySnapshot = await _collectionRef.get();
    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
    Map ListPlace = allData.asMap(); // carga los doc almacenados en la ruta place de firestore

    for (int i = 0; i < ListPlace.length; i++) {
      listTitles.add(ListPlace[i]['title']);
      listUrl.add(ListPlace[i]['url']);
    } // almacena el listado de lugares y las urls de la imagenes


       final docRef = FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser?.uid);
       DocumentSnapshot doc = await docRef.get();
       final data = doc.data() as Map;
       List ListFavFire = data['fav'];
       print(ListFavFire);

    final ListBox = GetStorage(); // gestor de almacenamiento local.
    ListBox.write('Titles', listTitles); //titulos de los lugares
    ListBox.write('Urls', listUrl);// urls de la imagenes
    ListBox.write('Isfav', ListFavFire); // lugares favoritos

    return ListPlace;
  }


  //Función para hacer que el Splash dure 5 segundos y pase a la login page
  Future<void> _closeSplash() async {
    const irPage = [LoginPage(),TabPage()];
    dynamic ir;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final bool? UserVal = prefs.getBool('setUserVal');
    if(UserVal==true ){ir = irPage[1]; }else{ir = irPage[0];}
    Future.delayed(const Duration(seconds: 5), () async {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ir ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Image(image: AssetImage('assets/images/entry.gif'),
        ),
      ),
    );
  }
}