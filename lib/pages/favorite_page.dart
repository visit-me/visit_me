import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:visit_me/pages/PlaceView.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
final ListBox = GetStorage();
final listFireFav = ListBox.read('IsFav');
List fav =[];

class FavPage extends StatefulWidget {
  const FavPage({super.key});

  @override
  State <FavPage> createState() => new FavPageState();
}

class FavPageState  extends State<FavPage> {

  FirebaseFirestore db  = FirebaseFirestore.instance;

   dynamic SetFire() async {

     var collection = FirebaseFirestore.instance.collection('place');
     collection
         .doc('1')
         .update({'fav' : 'true'}) // <-- Updated data
         .then((_) => print('Success'))
         .catchError((error) => print('Failed: $error'));
      }


  dynamic getPlace (){
   ListBox.read('FavList') == null? null :
   fav.addAll(ListBox.read('FavList'));
  }

  dynamic isFav(String place){
    bool isbool;
    fav.contains(place) ? isbool = true : isbool = false;
    return isbool;
  }

  dynamic addFav(String place){
    fav.add(place);
    ListBox.write('FavList',fav);
    SetFire();
  }

  dynamic removeFav(String place){
    fav.remove(place);
    ListBox.write('FavList',fav);
  }

  @override
  Widget build(BuildContext context) {
    List L = fav;


     return Scaffold(
        appBar: AppBar(
            title: Text("VISIT-ME"),
            backgroundColor:  Colors.white10,
            surfaceTintColor: Colors.transparent,
            elevation: 0,
            centerTitle:true
        ),
    body: Stack(
      children: <Widget>[
      ListTile(title: Text("LUGARES FAVORITOS", textAlign: TextAlign.center,),) ,
      L.length >0 ?
       Center(
            child:
            ListView.builder(
                itemCount: L.length,
                itemBuilder: (context, index) {
                  return Card(
                      child: Column(
                      children: [
                      Container(
                      height: 260,
                      decoration: BoxDecoration(
                      /*image: DecorationImage(
                      image: NetworkImage(img[index]),
                      fit: BoxFit.cover,
                      )*/)),
                       ListTile(
                        /*onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const HomePage(),));
                        },*/
                        title: Text(L[index]),
                        tileColor:Colors.white24,
                        //subtitle: Text(subtitles[index]),
                       trailing:Icon(Icons.favorite, color: Colors.teal,),
                        //trailing: Icon(icons[0])
                      )])
                    );
                    })
            )
       :const Center(child: Text('No items'))
      ],)
    );
  }
}