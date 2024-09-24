import 'package:flutter/material.dart';

class SignalerPage extends StatefulWidget {
  const SignalerPage({super.key});

  @override
  State<SignalerPage> createState() => _SignalerPageState();
}

class _SignalerPageState extends State<SignalerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Image.asset("assets/logo_epsi_portal2.png", width: 230,),
      ),
      body: Text('Signaler'),
    );
  }
}
