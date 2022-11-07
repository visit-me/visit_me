import 'package:flutter/material.dart';

class CardImage extends StatelessWidget {
  const CardImage({super.key});

  @override
  Widget build(BuildContext context) {

    final card = Container(
      height: 230,
      width: 365.0,
      margin: const EdgeInsets.only(
        top:5 ,
        left: 10,
        right: 10
      ),
      decoration: const BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage("assets/images/malecon.jpg")
        ),
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        shape: BoxShape.rectangle,
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black38,
            blurRadius: 0,
            offset: Offset(0.0, 7.0)
          )
        ]
      ),
    );

    return card;
  }
}