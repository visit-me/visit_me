import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:visit_me/pages/login_page.dart';
import 'package:visit_me/repository/firebase_api.dart';
import 'dart:convert';
import '../models/user.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  final FirebaseApi _firebaseApi = FirebaseApi();

  final _name = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _repPassword = TextEditingController();

  String _data = 'Información :';

  //Función para mostrar el mensage de warning de las contraseñas diferentes
  void _showMessage(String message) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(content: Text(message),
      action: SnackBarAction(
        label: 'Aceptar', onPressed: scaffold.hideCurrentSnackBar
      ),)
    );
  }

  //Función para guardar el usuario
  void saveUser(User user) async {
    //SharedPreferences prefs = await SharedPreferences.getInstance();
    //prefs.setString('user', jsonEncode(user));
    var result = await _firebaseApi.registerUser(user.email, user.password);
    String msg = '';

    if (result == 'invalid-email') {
      msg = 'El correo electrónico no es valido';
    } else if (result == 'weak-password') {
      msg = 'La contraseña debe tener mínimo 6 digitos';
    } else if (result == 'email-already-in-use') {
      msg = 'Ya existe una cuenta con ése correo electrónico';
    } else if (result == 'network-request-failed') {
      msg = 'Revise su conexión a internet';
    } else {
      msg = 'Usuario registrado con éxito';
    }

    _showMessage(msg);
  }

  void _onRegisterButtonClicked() {
    setState(() {
      if (_password.text == _repPassword.text) {
        //_data = 'Nombre: ${_name.text} \nCorreo electrónico: ${_email.text}';
        var user = User(_name.text, _email.text, _password.text);
        saveUser(user);
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginPage()));
      } else {
        _showMessage('Las contaseñas deben ser iguales');
      }
      
    });
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
                const SizedBox(
                  height: 16.0,
                ),
                TextFormField(
                  controller: _name,
                  decoration: const InputDecoration(
                      //border: OutlineInputBorder(borderRadius: BorderRadius.circular(32)),
                      labelText: 'Nombre',
                      icon: Padding(
                        padding: EdgeInsets.only(),
                        child: Icon(Icons.person),
                      )
                  ),
                  keyboardType: TextInputType.text,
                ),
                const SizedBox(
                  height: 16.0,
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
                TextFormField(
                  controller: _repPassword,
                  decoration: const InputDecoration(
                    //border: OutlineInputBorder(borderRadius: BorderRadius.circular(32)),
                      labelText: 'Repetir Contraseña',
                    icon: Padding(
                      padding: EdgeInsets.only(),
                      child: Icon(Icons.lock),
                    )
                  ),
                  keyboardType: TextInputType.text,
                  obscureText: true,
                ),
                const SizedBox(
                  height: 16.0,
                ),
                ElevatedButton(
                  style: TextButton.styleFrom(
                    textStyle: const TextStyle(fontSize: 16),
                  ),
                  onPressed: () {
                    _onRegisterButtonClicked();
                  },
                  child: const Text('Registrar'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}