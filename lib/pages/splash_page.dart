import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:visit_me/pages/login_page.dart';
import 'package:visit_me/pages/tab_page.dart';

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

  //Función para hacer que el Splash dure 5 segundos y pase a la login page
  Future<void> _closeSplash() async {
    const irPage = [LoginPage(),TabPage()];
    dynamic ir;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final bool? UserVal = prefs.getBool('setUserVal');
    if(UserVal==true ){ir = irPage[1]; }else{ir = irPage[0];}
    Future.delayed(const Duration(seconds: 6), () async {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ir ));
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