import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hive/hive.dart';
import 'package:visit_me/pages/PlaceView.dart';
import 'package:visit_me/pages/tab_page.dart';
final ListBox = GetStorage();
var box = Hive.box('myBox');

class FavPage extends StatefulWidget {
  const FavPage({super.key});

  @override
  State <FavPage> createState() => new FavPageState();
}

class FavPageState  extends State<FavPage> {
  Map titleUrls = ListBox.read('titleUrls');
  List fav = [];

  void initState(){
    super.initState();
  }

  dynamic getFire() async {
    final docRef = FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser?.uid);
    DocumentSnapshot doc = await docRef.get();
    final data = doc.data() as Map;
    List ListFavFire = data['fav'];
    print(ListFavFire);
    ListBox.write('Isfav', ListFavFire);

    for (int i = 0; i < ListFavFire.length; i++) {
      if(isFav(ListFavFire[i])==false)
      {fav.add(ListFavFire[i]);
      }
    }
    ListBox.write('FavList',fav);
  }

   dynamic setFire() async {
     var collection = FirebaseFirestore.instance.collection('users');
     collection
         .doc(FirebaseAuth.instance.currentUser?.uid)
         .set({'fav' : fav}, SetOptions(merge: true)) // <-- Updated data
         .then((_) => print('Success'))
         .catchError((error) => print('Failed: $error'));
      }//almacea los favoritos en firestore

  dynamic isFav(String place){
    bool isbool;
    fav.contains(place) ? isbool = true : isbool = false;
    return isbool;
  }

  void _showAlertDialog(int index) {
    showDialog(
        context: context,
        builder: (buildcontext) {
          return AlertDialog(
            title: Text("Eliminar de favoritos"),
            content: Text("¿seguro que quieres eliminar este lugar?"),
            actions: <Widget>[
              TextButton(
                child: Text("Eliminar", style: TextStyle(color: Colors.red),),
                onPressed: (){FavBottomState().removeFav(fav[index]);
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

  @override
  Widget build(BuildContext context) {
     print(fav);

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
     body: Stack(
              children: <Widget>[
              (fav.length>0 && fav[0]!= 'nada') ? // comprueba que L es un array
               Center(
                    child:ListView.builder(
                        itemCount: fav.length, // determina el numero de elementos en el array L
                        itemBuilder: (context, index) {
                          return Card(
                              child: Column(
                              children: [
                                InkWell(child:Container(
                                    height: 260,
                                    decoration: BoxDecoration(
                                    image: DecorationImage(
                                    image:NetworkImage(titleUrls[fav[index]]),
                                    fit: BoxFit.cover,
                                    ))),onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) => loadingPage(p:index,url:titleUrls[fav[index]]),
                                        ));// se emplea el Inkwell para la funcion de onTap y enviar al viewplace
                                      },
                                ),
                               ListTile(
                                /*onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => loadingPage(p:index,url:img[index])),
                                  );
                                },*/ // se desactiva para que al precionar en el listtitle no interfiera en el elimar de fav
                                title: Text(fav[index]),
                                tileColor:Colors.white24,
                                //subtitle: Text(subtitles[index]),
                               trailing: IconButton(
                                 icon:Icon(Icons.favorite),
                                 onPressed: () => { _showAlertDialog(index)},// llama a eliminar fav desde el icono.
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
              ],)
    );
  }
}