import 'package:flutter/material.dart';
import 'package:visit_me/ventana/components/card_list.dart';
import 'package:visit_me/ventana/components/gradient_back.dart';

class HeaderAppBar extends StatelessWidget {
  const HeaderAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: const <Widget>[
        GradientBack(),
        CardList(),
      ],
    );
  }
}