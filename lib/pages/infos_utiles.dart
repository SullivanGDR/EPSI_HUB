import 'package:flutter/material.dart';

class InfosUtilesPage extends StatefulWidget {
  const InfosUtilesPage({super.key});

  @override
  State<InfosUtilesPage> createState() => _InfosUtilesPageState();
}

class _InfosUtilesPageState extends State<InfosUtilesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Image.asset("assets/logo_epsi_portal2.png", width: 230,),
      ),
      body: Text('Infos Utiles'),
    );
  }
}
