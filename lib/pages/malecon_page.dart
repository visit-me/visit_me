import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:visit_me/malecon/components/header_appbar.dart';
import '../malecon/components/description_place.dart';


class MaleconPage extends StatefulWidget {
  const MaleconPage({super.key});

  @override
  State<MaleconPage> createState() => _MaleconPageState();
}

class _MaleconPageState extends State<MaleconPage> {
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