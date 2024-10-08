import 'package:epsi_hub/pages/forum.dart';
import 'package:epsi_hub/pages/home.dart';
import 'package:epsi_hub/pages/infos_utiles.dart';
import 'package:epsi_hub/pages/login.dart';
import 'package:epsi_hub/pages/map.dart';
import 'package:epsi_hub/pages/profil.dart';
import 'package:epsi_hub/pages/register.dart';
import 'package:epsi_hub/pages/signalements.dart';
import 'package:epsi_hub/pages/signalementsAdmin.dart';
import 'package:epsi_hub/pages/signaler.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EPSI Hub',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const HomePage(),
      routes: <String, WidgetBuilder>{
        '/accueil': (BuildContext context) => const HomePage(),
        '/forum': (BuildContext context) => const ForumPage(),
        '/profil': (BuildContext context) => const Profil(),
        '/map': (BuildContext context) => const MapPage(),
        '/infos': (BuildContext context) => InfosUtilesPage(),
        '/signaler': (BuildContext context) => const SignalerPage(),
        '/register': (BuildContext context) => const RegisterPage(),
        '/login': (BuildContext context) => const LoginPage(),
        '/signalements': (BuildContext context) => const SignalementsPage(),
        '/signalementsAdmin': (BuildContext context) => const SignalementsAdminPage()
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
