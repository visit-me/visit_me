import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:visit_me/components/card_list.dart';
import 'package:visit_me/firebase_options.dart';
import 'package:visit_me/pages/list_poi.dart';
import 'package:visit_me/pages/splash_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );

  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarBrightness: Brightness.light
      ));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Visit-Me',
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', 'US'),
        Locale('es', 'CO'),
      ],
      theme: ThemeData(
        primarySwatch: Colors.pink,
        navigationBarTheme: NavigationBarThemeData(
          backgroundColor: Colors.pink.shade100,
          indicatorColor: Colors.pink.shade500,
        ),
      ),

      darkTheme: ThemeData(
        primarySwatch: Colors.pink,
        brightness: Brightness.dark,
      ),

      //Remove the debug banner
      debugShowCheckedModeBanner: false,

      home: const SplashPage(),
    );
  }
}

