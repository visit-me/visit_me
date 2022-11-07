import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:visit_me/aleta/components/header_appbar.dart';
import '../aleta/components/description_place.dart';


class AletaPage extends StatefulWidget {
  const AletaPage({super.key});

  @override
  State<AletaPage> createState() => _AletaPageState();
}

class _AletaPageState extends State<AletaPage> {
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