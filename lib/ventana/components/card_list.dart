import 'package:flutter/material.dart';
import 'package:visit_me/ventana/components/card_image.dart';

class CardList extends StatelessWidget {
  const CardList({super.key});


  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.topCenter,
        child: SizedBox(
          height: 300,
          child: ListView(
            padding: const EdgeInsets.all(5.0),
            scrollDirection: Axis.horizontal,
            children: const <Widget>[
              CardImage(),
          ],
          ),
        )
    );
  }
}
