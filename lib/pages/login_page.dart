import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:visit_me/pages/register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _email = TextEditingController();
  final _password = TextEditingController();

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
                  onPressed: () {}, child: const Text('Iniciar Sesión')),
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
        ),
      ),
    );
  }
}