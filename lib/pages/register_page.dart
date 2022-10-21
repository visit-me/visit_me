import 'dart:html';

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

  String _data = '';
  
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
                    labelText: 'Correo Electrónico',
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
              ElevatedButton(
                style: TextButton.styleFrom(
                  textStyle: const TextStyle(fontSize: 16),
                ),
                onPressed: () {

                },
                child: const Text('Registrar'),
              ),
              Text(
                _data,
                style: const TextStyle(
                  fontSize: 12, fontStyle: FontStyle.italic
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}