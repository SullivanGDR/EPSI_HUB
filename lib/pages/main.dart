import 'package:epsi_hub/pages/events.dart';
import 'package:epsi_hub/pages/forum.dart';
import 'package:epsi_hub/pages/home.dart';
import 'package:epsi_hub/pages/infos_utiles.dart';
import 'package:epsi_hub/pages/map.dart';
import 'package:epsi_hub/pages/nos_apprenants.dart';
import 'package:epsi_hub/pages/reservations.dart';
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
        '/events': (BuildContext context) => const EventsPage(),
        '/map': (BuildContext context) => const MapPage(),
        '/reservations': (BuildContext context) => const ReservationsPage(),
        '/infos': (BuildContext context) => const InfosUtilesPage(),
        '/nos-apprenants': (BuildContext context) => const NosApprenantsPage(),
        '/signaler': (BuildContext context) => const SignalerPage(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
