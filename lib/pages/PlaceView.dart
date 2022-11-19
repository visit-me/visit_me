import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:visit_me/pages/Map_view.dart';
import 'package:visit_me/pages/tab_page.dart';
import 'Screensize_reducers.dart';
final ListBox = GetStorage();

class loadingPage extends StatefulWidget {
   final int p; // p toma el valor del index o posicion de lista de lugares
   final String url; // toma url de lista de lugares
   const loadingPage({super.key, required this.p, required this.url});

  @override
  State <loadingPage> createState() => _loadingPageState();

}

class _loadingPageState extends State<loadingPage> {
  late final String c1;
  late final double  c2;
  late final double  c3;
  late final String c4;
  @override
  CollectionReference _collectionRef = FirebaseFirestore.instance.collection('place');

  Future<Map> getPlace() async {
    QuerySnapshot querySnapshot = await _collectionRef.get();
    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
    Map ListPlace = allData.asMap();

    c1 = ListPlace[widget.p]['title'];
    c2 = ListPlace[widget.p]['latitude'];
    c3 = ListPlace[widget.p]['longitude'];
    c4 = ListPlace[widget.p]['address'];

    Map s =  ListPlace;
    return s;
  }// carga los datos de firebase para  actualizar en la carga de page

  @override
  void initState() {
    getPlace();
    super.initState();
  }

Widget build(BuildContext context) {
  var Ancho = screenWidth(context, dividedBy: 1); // clase que se encarga de obtener el ancho de la pantalla


   return Scaffold(
      resizeToAvoidBottomInset: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(""),
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute( builder: (context) => MapView(lat:c2 ,long: c3 ,adr:c4 , title: c1, ) ));
          }
        , label:Text('Mapa ') ,icon: Icon(Icons.map_outlined),
      ),
      body:
      FutureBuilder<Map>(
          future: getPlace(),
          builder: (BuildContext context, AsyncSnapshot snapshot){
            Map? killa = snapshot.data; // resultado de la funcion, requerido para el futurebuilder.
            print(killa);
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
                String k = killa[p]['title'];

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
                            Align(
                              alignment: Alignment.center,
                              child: Container(
                                margin: const EdgeInsets.only(
                                    top: 5.0,
                                  ),
                                child: FavBottom(f:k,)
                                ),
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
class FavBottom extends StatefulWidget {
  final f;
  const FavBottom({super.key, this.f});

State < FavBottom> createState() =>  FavBottomState();

}



class FavBottomState extends State<FavBottom> {

  List fav = ["nada"];

  void initState(){
    if(ListBox.read('FavList')!=null){
    List ListF = ListBox.read('FavList');
    for (int i = 0; i < ListF.length; i++) {
      if(fav.contains(ListF[i])==false)
      {fav.add(ListF[i]);
      }
    }
    ListBox.write('FavList',fav);}
    super.initState();
  }

  dynamic isInFav(String place){
    bool isbool;
    fav.contains(place) ? isbool = true : isbool = false;
    return isbool;
  }// comprueba que el lugar exista en la lista de favoritos.

  dynamic addFav(String place){
    fav.add(place);
    ListBox.write('FavList',fav);
  }// agrega nuevo lugar a favoritos y lo almacena localmente

  dynamic removeFav(String place){
    fav.remove(place);
    ListBox.write('FavList',fav);
  }//remueve nuevo lugar a favoritos y lo elimina localmente

  @override
  Widget build(BuildContext context) {

    String f = widget.f;
    bool isfav = isInFav(f);

    return TextButton.icon( // <-- TextButton
      onPressed: () {
        // bolean de fuciones addFav y removeFav
        isfav
            ? removeFav(f)
            : addFav(f);
        setState(() {
          isfav = !isfav;
        });
       print(ListBox.read('FavList'));
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
