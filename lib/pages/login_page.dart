import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:visit_me/pages/register_page.dart';

import '../models/user.dart';
import 'home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _email = TextEditingController();
  final _password = TextEditingController();

  User userLoad = User.Empty();

  @override
  void initState() {
    _getUser();
    super.initState();
  }

  //Traer el usuario del registro
  _getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> userMap = jsonDecode(prefs.getString('user')!);
    userLoad = User.fromJson(userMap);
  }

  //Función para mostrar el mensage de warning si el usuario no es encontrado
  void _showMessage(String message) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(content: Text(message),
      action: SnackBarAction(
        label: 'Aceptar', onPressed: scaffold.hideCurrentSnackBar
      ),)
    );
  }

  //Función para comparar los datos registrados en las preferencias compartidas
  void _validateUser() {
    if(_email.text == userLoad.email && _password.text == userLoad.password) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomePage()));
    } else {
      _showMessage('Correo o contraseña inválidos');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Image(image: AssetImage('assets/images/logo.png')),
              const SizedBox(height: 16.0,
              ),
              TextFormField(
                  controller: _email,
                  decoration: const InputDecoration(
                    //border: OutlineInputBorder(borderRadius: BorderRadius.circular(32)),
                      labelText: 'Correo electrónico',
                      icon: Padding(
                        padding: EdgeInsets.only(),
                        child: Icon(Icons.email),
                      )
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(
                  height: 16.0,
                ),
                TextFormField(
                  controller: _password,
                  decoration: const InputDecoration(
                    //border: OutlineInputBorder(borderRadius: BorderRadius.circular(32)),
                    labelText: 'Contraseña',
                    icon: Padding(
                      padding: EdgeInsets.only(),
                      child: Icon(Icons.lock),
                    ),
                  ),
                  keyboardType: TextInputType.text,
                  obscureText: true,
                ),
                const SizedBox(
                  height: 16.0,
                ),
                ElevatedButton(
                  onPressed: () {
                    _validateUser();
                  }, child: const Text('Iniciar Sesión')),
                TextButton(
                  style: TextButton.styleFrom(
                    textStyle: const TextStyle(
                      fontSize: 16,
                      fontStyle: FontStyle.italic,
                      color: Colors.yellow
                    ),
                  ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RegisterPage(),));
                    },
                    child: const Text('Registrarse'),
                ),
            ],
          ),
          )
          ),
      ),
    );
  }
}