import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:visit_me/ventana/components/header_appbar.dart';
import '../ventana/components/description_place.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: Text(""),
            backgroundColor: Colors.transparent,
            surfaceTintColor: Colors.transparent,
            elevation: 0,
        ),
      body: Stack(
      children: const <Widget>[
          HeaderAppBar(),
          DescriptionPlace(),
        ],
      )
    );
  }
}






