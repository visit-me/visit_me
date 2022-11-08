// ignore_for_file: void_checks

import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:visit_me/pages/login_page.dart';
import '../models/user.dart';

class LogCard extends StatefulWidget {
  const LogCard({Key? key}) : super(key: key);
  @override
  State<LogCard> createState() => _LogCardState();
}

class _LogCardState extends State<LogCard> {
  bool shadowColor = false;
  late String stringName = "vi";
  late String stringEmail = "vi";
  get userMail => null;
  List dataString=["user@visit-me.com","visit-me"];

  Future<List> _profdata() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? userMail = prefs.getString('userMail');
      if(userMail != null){
      stringEmail = userMail;
      for (int i = 0; i < userMail.length; i++) {
        if(userMail[i] == "@"){
          stringName = userMail.substring(0, i);
          break;}}}
    dataString = [stringEmail,stringName];
    return dataString;
    }

  void getValueName(){}

  @override
  void initState() {
    _profdata();
    super.initState();
  }

   void sendout() async {
     SharedPreferences prefs = await SharedPreferences.getInstance();
     await prefs.setBool('setUserVal', false);
     final bool? UserVal = prefs.getBool('setUserVal');
     print(UserVal);

  }

  @override
  Widget build(BuildContext context) {
    String sName = _LogCardState().dataString[1]  ;
    String ico = _LogCardState().dataString[0].substring(0, 1);
    String sEmail = _LogCardState().dataString[0];

    return ListView.builder(
        itemCount: 1,
        itemBuilder: (context, index) {
         return Card(
            child:  Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Row(children: [Container(height: 50,)],),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[  CircleAvatar(
                      backgroundColor: Colors.green,
                      radius: 115,
                      child: CircleAvatar(
                        backgroundColor: Colors.greenAccent[100],
                        radius: 110,
                        child: CircleAvatar(backgroundColor: Color(0xFFB2DFDB),
                            child: Text('visit-me', style: TextStyle(fontSize: 35, color: Colors.white)),
                            radius: 100), //CircleAvatar
                      ), //CircleAvatar
                    ), //CircleAvatar
                    ]),
                Row(children: [Container(height: 50,)],),

                  ListTile(
                  title: Text(sName),
                  subtitle: Text(sEmail),
                  leading: CircleAvatar(backgroundColor: Color(0xFFB2DFDB),child: Text(ico), radius: 30.0,),//trailing: Icon(Icons.favorite_border)
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    TextButton(
                      child: const Text('logout'),
                      onPressed: () {
                      _LogCardState().sendout();
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));

                      }, // <- aquí va el llamado a la función logout
                    ),
                  ],
                ),
              ],
            ),
          );
        });
      }
    }

