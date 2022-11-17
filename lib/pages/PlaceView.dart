import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:visit_me/pages/favorite_page.dart';

import 'Screensize_reducers.dart';
final ListBox = GetStorage();
List fav = ListBox.read('IsFav');

class loadingPage extends StatefulWidget {

  final int p; // p toma el valor del index o posicion de lista de lugares
   final String url; // toma url de lista de lugares
   const loadingPage({super.key, required this.p, required this.url});

  @override
  State <loadingPage> createState() => _loadingPageState();

}

class _loadingPageState extends State<loadingPage> {

  @override
  CollectionReference _collectionRef =
  FirebaseFirestore.instance.collection('place');

  Future<Map> getPlace() async {
    /*QuerySnapshot querySnapshot = await _collectionRef.get();
    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
    Map ListPlace = allData.asMap();*/
    Map ListPlace = ListBox.read('MapPlace');
    return ListPlace;
  }// carga los datos de firebase para  actualizar en la carga de page

  @override
  void initState() {
    getPlace();
    super.initState();
  }


Widget build(BuildContext context) {
  var Ancho = screenWidth(context, dividedBy: 1); // clase que se encarga de obtener el ancho de la pantalla

   return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(""),
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: (){

          // <- aqui va el navigetor para ir a la pagina de mapa

        }
        , label:Text('Mapa ') ,icon: Icon(Icons.map_outlined),
      ),
      body:
      FutureBuilder<Map>(
          future: getPlace(),
          builder: (BuildContext context, AsyncSnapshot snapshot){
            Map? killa = snapshot.data; // resultado de la funcion, requerido para el futurebuilder.
            int p = widget.p; // getter del valor p.
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.error != null) {
              return const Center(child: Text('an error occured!'));
            } else{
              if(killa == null) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else{ // los validadores de la no nulilidad del los datos traidos de firebase

                return Stack(children:<Widget>[
                  Container(
                    height: 315.0,
                    decoration: const BoxDecoration(
                        gradient: LinearGradient(
                            colors: [
                              Color(0xFFB2DFDB),
                              Color(0xFFB2DFDB)
                            ],
                            begin: FractionalOffset(0.0, 0.0),
                            end: FractionalOffset(0.0, 1.5),
                            stops: [0.0, 0.5],
                            tileMode: TileMode.clamp
                        )
                    ),
                  ),
                  Align(
                      alignment: Alignment.topCenter,
                      child: SizedBox(
                          height: 300,
                          child: Container(
                            height: 200,
                            width: (Ancho-20),
                            margin: const EdgeInsets.only(
                                top:10,
                                left: 10,
                                right: 10
                            ),
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(widget.url)
                                ),
                                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                                shape: BoxShape.rectangle,
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                      color: Colors.black38,
                                      blurRadius: 0,
                                      offset: Offset(0.0, 7.0)
                                  )
                                ]
                            ),
                          )
                      )
                  ),
                  //DescriptionPlace()
                  ListView.builder(
                      itemCount: 1,
                      itemBuilder: (context, index) {
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Row(children: [Container(height: 240,)],),

                            Align(
                              //alignment: Alignment.centerLeft,
                              child: Container(
                                margin: const EdgeInsets.only(
                                    top: 20,
                                    left: 20.0,
                                    right: 20.0
                                ),
                                child: Text( killa[p]['title'],
                                  style: TextStyle(
                                      fontSize: 25.0,
                                      fontWeight: FontWeight.w900
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,

                              children: <Widget>[
                                Container(
                                    height: 40,
                                    child:FavBottom(p:p,))
                              ],
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                margin: const EdgeInsets.only(
                                    top: 5.0,
                                    left: 20.0,
                                    right: 20.0
                                ),
                                child: Text('Ciudad: '+killa[p]['city'],
                                  style: TextStyle(
                                    fontSize: 16.0,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                margin: const EdgeInsets.only(
                                  //top: 20.0,
                                    left: 20.0,
                                    right: 20.0
                                ),
                                child: Text('Departamento: '+killa[p]['department'],
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                            ),

                            Align(
                              alignment: Alignment.centerLeft,
                              child: Container(

                                margin: const EdgeInsets.only(
                                  //top: 20.0,
                                    left: 20.0,
                                    right: 20.0
                                ),
                                child: Text('Temperatura: '+killa[p]['temperature'],
                                  style: TextStyle(
                                    fontSize: 16.0,),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                            ),

                            Container(
                              margin: const EdgeInsets.only(
                                  top: 20.0,
                                  right: 20.0,
                                  left: 20.0
                              ),
                              child: Text(killa[p]['description'],
                                style: TextStyle(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.w400,
                                ),
                                textAlign: TextAlign.justify,
                              ),
                            ),

                          ],
                        );
                      })
                ]

                );

              }}}
      )
  );
}


}
// otro boton flotante de ejemplo
class FavBottom extends StatefulWidget {
  final p;
  const FavBottom({super.key, this.p});

State < FavBottom> createState() =>  FavBottomState();

}

class FavBottomState extends State<FavBottom> {
  @override
  Widget build(BuildContext context) {
  return FutureBuilder<Map>(
        future:_loadingPageState().getPlace(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            Map? killa = snapshot
                .data; // resultado de la funcion, requerido para el futurebuilder.
            int p = widget.p; // getter del valor p.
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            else if (snapshot.error != null) {
              return const Center(child: Text('an error occured!'));
            }
            else {
              bool isfav = FavPageState().isFav(killa![p]['title']);
              if (killa == null) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return TextButton.icon( // <-- TextButton
                  onPressed: () {
                    // bolean de fuciones addFav y removeFav
                    isfav
                        ? FavPageState().removeFav(killa[p]['title'])
                        : FavPageState().addFav(killa[p]['title']);
                    setState(() {
                      isfav = !isfav;
                    });
                    //Navigator.of(context).push(MaterialPageRoute(builder: (context) =>TabPage(tab: 1,)));
                  },
                  icon: Icon(
                    isfav ? Icons.favorite : Icons.favorite_border,
                    size: 24.0,
                  ),
                  label: Text(isfav ? "Favorito" : "Agregar a favoritos"),
                );
              }
            }
        });
  }
}
