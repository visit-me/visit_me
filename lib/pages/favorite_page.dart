import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/utils.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:visit_me/pages/PlaceView.dart';
import 'package:visit_me/pages/tab_page.dart';
final ListBox = GetStorage();


class FavPage extends StatefulWidget {
  const FavPage({super.key});

  @override
  State <FavPage> createState() => new FavPageState();
}

class FavPageState  extends State<FavPage> {
  Map titleUrls = ListBox.read('titleUrls');
  List fav=[];
  void initState(){
    getFav();
    super.initState();
  }


   dynamic setFire() async {

     final prefs = await SharedPreferences.getInstance();
     final String? pag = prefs.getString('pagFav');
     List<dynamic>? pagFav = pag!.split(',');

     var collection = FirebaseFirestore.instance.collection('users');
     collection
         .doc(FirebaseAuth.instance.currentUser?.uid)
         .set({'fav' : pagFav}, SetOptions(merge: true)) // <-- Updated data
         .then((_) => print('Success'))
         .catchError((error) => print('Failed: $error'));
      }//almacea los favoritos en firestore


  void _showAlertDialog(String str, int str2) {
    showDialog(
        context: context,
        builder: (buildcontext) {
          return AlertDialog(
            title: Text("Eliminar de favoritos"),
            content: Text("¿seguro que quieres eliminar este lugar?"),
            actions: <Widget>[
              TextButton(
                child: Text("Eliminar", style: TextStyle(color: Colors.red),),
                onPressed: (){
                Navigator.of(context).pop();
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => TabPage(tab: 1,)));
                  },
              ),
              TextButton(
                child: Text("Cancelar", style: TextStyle(color: Colors.blue),),
                onPressed: (){ Navigator.of(context).pop(); },
              )
            ],
          );
        }
    );
  }


  Future<Map> getFav() async {
    final prefs = await SharedPreferences.getInstance();
    final String? pag = prefs.getString('pagFav');
    List<dynamic>? pagFav = pag!.split(',');


    final String? pag2 = prefs.getString('titlespost');
    List<dynamic>? pagFav2 = pag2!.split(',');
    Map titleP ={"favs":pagFav,"titles":ListBox.read('Titles'),'position':pagFav2};
    return titleP;

  }



  @override
  Widget build(BuildContext context) {

      return Scaffold(
        appBar: AppBar(
            title: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "VISIT-ME",
                      ),
                  Text(
                    "LUGARES FAVORITOS",
                    style: TextStyle(fontSize: 12.0),
                  ),
                ]
            ),actions: <Widget>[
              
                IconButton(
                  icon: const Icon(Icons.cloud_upload_outlined),
                  onPressed: () {
                    FavPageState().setFire();
                    var snackBar = SnackBar(content: Text("se han guardado sus favoritos :D"));
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    },)
                          ],
            backgroundColor:  Colors.white10,
            surfaceTintColor: Colors.transparent,
            elevation: 0,
            centerTitle:true
        ),
          // configura el app bar
     body: FutureBuilder (
          future: getFav(),
          builder: (BuildContext context, AsyncSnapshot snapshot){
           List lf = snapshot.data["favs"];
           List lt = snapshot.data["titles"];
           Map Mtp = {};
           List<int> lp = [];

           int count = 0;
           for(int i=0; i<lf.length; i++){
            if(lf[i].isEmpty || lf[i]==null){
              print("empty " + i.toString());
            } else {
              count++;
            }
          }


            for (var i in snapshot.data['position']){
              int? value = int.tryParse(i);
              lp.add(value!);
            }

           for(int i=0; i<lt.length; i++){
             Mtp[lt[i]]=lp[i];
           }

    return Stack(
    children: <Widget>[
    (count>0) ? // comprueba que L es un array
    Center(
    child:ListView.builder(
    itemCount: lf.length, // determina el numero de elementos en el array L
    itemBuilder: (context, index) {
    return Card(
    child: Column(
    children: [
    InkWell(child:Container(
    height: 260,
    decoration: BoxDecoration(
    image: DecorationImage(
    image:NetworkImage(titleUrls[lf[index]]),
    fit: BoxFit.cover,
    ))),onTap: () {
    Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => loadingPage(p:Mtp[lf[index]],url:titleUrls[lf[index]]),
    ));// se emplea el Inkwell para la funcion de onTap y enviar al viewplace
    },
    ),
    ListTile(
    title: Text(lf[index]),
    tileColor:Colors.white24,
    //subtitle: Text(subtitles[index]),
    trailing: IconButton(
    icon:Icon(Icons.favorite),
    onPressed: () => {
      _showAlertDialog(lf[index], lp[index])
    },// llama a eliminar fav desde el icono.
    color:Colors.teal,
    padding: EdgeInsets.all(10.0),
    ),
    //trailing: Icon(icons[0])
    )]
    )
    );
    })
    ):Align(child: Container(
    height: 150,
    padding: EdgeInsets.all(20), //You can use EdgeInsets like above
    margin: EdgeInsets.all(20),
    child: Center(child: Text('No tienes favoritos aun, puedes agregarlo ingresadon a las tarjetas en lugares')),
    )), //texto en caso de no hallar favoritos
    ],);

    })
    );
  }
}