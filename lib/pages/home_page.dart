import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:visit_me/components/description_place.dart';
import 'package:visit_me/components/header_appbar.dart';
import 'package:visit_me/pages/favorite_page.dart';
import 'package:visit_me/pages/list_poi.dart';
import 'package:visit_me/pages/tab_page.dart';


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






