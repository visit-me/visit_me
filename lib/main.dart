import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_storage/get_storage.dart';
import 'package:visit_me/firebase_options.dart';
import 'package:visit_me/pages/splash_page.dart';
import 'package:visit_me/pages/tab_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  await GetStorage.init();
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
        useMaterial3: true,
        primarySwatch: Colors.teal,
        navigationBarTheme: NavigationBarThemeData(
          backgroundColor: Colors.teal.shade200,
          indicatorColor: Colors.teal.shade500,
        ),

      ),

      darkTheme: ThemeData(
        primarySwatch: Colors.blueGrey,
        brightness: Brightness.dark,
      ),
      initialRoute: '/',
      routes: {'/': (_) => SplashPage(), '/1': (_) => TabPage(),'/2': (_) => TabPage(tab: 1,)},
      //Remove the debug banner
      debugShowCheckedModeBanner: false,

    );
  }
}

