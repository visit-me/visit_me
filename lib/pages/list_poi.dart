import 'package:flutter/material.dart';
import 'package:visit_me/pages/home_page.dart';

class ListPoi extends StatelessWidget {
  const ListPoi({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
          children: <Widget>[
            ListTile(
              title: const Text('Ventana al mundo'),
              onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HomePage(),));
                      },
            ),
            ListTile(
              title: const Text('Aleta del tiburón'),
              onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HomePage(),));
                      },
            ),
            ListTile(
              title: const Text('Malecón'),
              onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HomePage(),));
                      },
            ),
          ]),
    )
      ;}}