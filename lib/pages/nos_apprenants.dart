import 'package:flutter/material.dart';

class NosApprenantsPage extends StatefulWidget {
  const NosApprenantsPage({super.key});

  @override
  State<NosApprenantsPage> createState() => _NosApprenantsPageState();
}

class _NosApprenantsPageState extends State<NosApprenantsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Image.asset("assets/logo_epsi_portal2.png", width: 230,),
      ),
      body: Text('Nos apprenants ont du talent'),
    );
  }
}
