import 'dart:convert';
import 'package:visit_me/pages/tab_page.dart';
import 'package:visit_me/repository/firebase_api.dart';
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

  final FirebaseApi _firebaseApi = FirebaseApi();

  final _email = TextEditingController();
  final _password = TextEditingController();

  User userLoad = User.Empty();

  @override
  void initState() {
    //_getUser();
    super.initState();
  }

  //Traer el usuario del registro
 /* void _getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> userMap = jsonDecode(prefs.getString('user')!);
    userLoad = User.fromJson(userMap);
  }*/

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
  void _validateUser() async {
    var result = await _firebaseApi.logInUser(_email.text, _password.text);
      String msg = '';

    if(_email.text.isEmpty || _password.text.isEmpty) {
      _showMessage('Debe ingresar un correo y una contraseña');
    } 

    if (result == 'invalid-email') {
      msg = 'El correo electrónico no es valido';
      _showMessage(msg);
    } else if (result == 'wrong-password') {
      msg = 'Correo o contraseña incorrectos';
      _showMessage(msg);
    } else if (result == 'network-request-failed') {
      msg = 'Revise su conexión a internet';
      _showMessage(msg);
    } else {
      msg = 'Bienvenido a Visit-Me :D';
      _showMessage(msg);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const TabPage()));
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