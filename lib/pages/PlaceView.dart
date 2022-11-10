import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:visit_me/pages/favorite_page.dart';
import 'package:visit_me/pages/list_poi.dart';
import 'Screensize_reducers.dart';

/*

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();

}

class _HomePageState extends State<HomePage> {


  @override
  Widget build(BuildContext context) {
    var Ancho = screenWidth(context, dividedBy: 1);
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: Text(""),
            backgroundColor: Colors.transparent,
            surfaceTintColor: Colors.transparent,
            elevation: 0,
        ),
      body:
         Stack(children: <Widget>[loadingPage(),]));
  }
}*/

class loadingPage extends StatefulWidget {
   final p;
   final url;
   const loadingPage({super.key, this.p, this.url});

  @override
  State <loadingPage> createState() => _loadingPageState();

}

class _loadingPageState extends State<loadingPage> {

  @override
  CollectionReference _collectionRef =
  FirebaseFirestore.instance.collection('place');

  Future<Map> getPlace() async {
    QuerySnapshot querySnapshot = await _collectionRef.get();
    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
    Map ListPlace = allData.asMap();
    return ListPlace;
  }

  @override
  void initState() {
    getPlace();
    super.initState();
  }

  Map ini = {0:{'title':'title','city':"Barranquilla",'department':"Atlántico",'temperature':'32°','description':"Espere joven"}};

Widget build(BuildContext context) {
  var Ancho = screenWidth(context, dividedBy: 1);
  return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(""),
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: null, label:Text('Fav') ,icon: Icon(Icons.favorite_border),
      ),
      body:
      FutureBuilder<Map>(
          future: getPlace(),
          initialData: ini,
          builder: (BuildContext context, AsyncSnapshot snapshot){

            Map? killa = snapshot.data!;
            int p = widget.p;

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.error != null) {
              return const Center(child: Text('an error occured!'));
            } else{
              if(killa == null) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else{

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
                                TextButton.icon(     // <-- TextButton
                                  onPressed: () {
                                    Navigator.
                                    pushReplacement(
                                        context, MaterialPageRoute(builder: (context) => FavPage()));
                                  },
                                  icon: Icon(
                                    Icons.map_outlined,
                                    size: 24.0,
                                  ),
                                  label: Text('Mapa'),
                                ),
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

class Floatbottomfav extends StatelessWidget {
  const Floatbottomfav({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Center(heightFactor: 2.5,
        child: Ink(
          decoration: const ShapeDecoration(
            color: Colors.transparent,
            shape: CircleBorder(),
          ),
          child: IconButton(
            iconSize: 30,
            icon: const Icon(Icons.favorite_border),
            color: Colors.blueGrey,
            focusColor: Colors.blue,
            onPressed: () {
            },
          ),
        ),
      ),
    );
  }
}
