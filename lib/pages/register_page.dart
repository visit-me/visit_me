import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  final _name = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _repPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Image(image: AssetImage('assets/images/logo.png')),
              const SizedBox(
                height: 16.0,
              ),
              TextFormField(
                controller: _name,
                decoration: InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(32)), labelText: 'Nombre'
                ),
                keyboardType: TextInputType.text,
              ),
              const SizedBox(
                height: 16.0,
              ),
              TextFormField(
                controller: _email,
                decoration: InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(32)), labelText: 'Correo Electrónico'
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(
                height: 16.0,
              ),
              TextFormField(
                controller: _password,
                decoration: InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(32)), labelText: 'Contraseña'
                ),
                keyboardType: TextInputType.text,
              ),
              const SizedBox(
                height: 16.0,
              ),
              TextFormField(
                controller: _repPassword,
                decoration: InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(32)), labelText: 'Repetir Contraseña'
                ),
                keyboardType: TextInputType.text,
              )
            ],
          ),
        ),
      ),
    );
  }
}