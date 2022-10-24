import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:visit_me/pages/login_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  //Inicializar la función _closeSplash
  void initState(){
    _closeSplash();
    super.initState();
  }

  //Función para hacer que el Splash dure solo 2 segundo y pase a la login page
  Future<void> _closeSplash() async {
    Future.delayed(const Duration(seconds: 6), () async {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginPage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Image(image: AssetImage('assets/images/entry.gif'),
        ),
      ),
    );
  }
}