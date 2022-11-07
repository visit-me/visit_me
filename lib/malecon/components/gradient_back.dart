import 'package:flutter/material.dart';

class GradientBack extends StatelessWidget {
  const GradientBack({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 310.0,
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
    );
  }
}