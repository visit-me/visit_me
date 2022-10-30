import 'package:flutter/material.dart';
import 'package:visit_me/components/card_image.dart';

class CardList extends StatelessWidget {
  const CardList({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.topCenter,
        child: SizedBox(
          height: 350,
          child: ListView(
            padding: const EdgeInsets.all(35.0),
            scrollDirection: Axis.horizontal,
            children: const <Widget>[
              CardImage(),
            ],
          ),
        )
    );
  }
}