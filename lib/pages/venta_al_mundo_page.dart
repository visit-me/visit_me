import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:visit_me/ventana/components/header_appbar.dart';
import '../ventana/components/description_place.dart';
import 'Screensize_reducers.dart';


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
      Stack(children:<Widget>[
          Container(
            height: 320.0,
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
          ),Align(
                  alignment: Alignment.topCenter,
                  child: SizedBox(
                    height: 300,
                    child: Container(
                                      height: 200,
                                      width: (Ancho-20),
                                      margin: const EdgeInsets.only(
                                          top:10 ,
                                          left: 10,
                                          right: 10
                                      ),
                                      decoration: const BoxDecoration(
                                          image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: AssetImage('assets/images/ventana.jpg')
                                          ),
                                          borderRadius: BorderRadius.all(Radius.circular(15.0)),
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
        DescriptionPlace()]
      )
    );
  }
}






