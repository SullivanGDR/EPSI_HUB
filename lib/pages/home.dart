import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("epsi portal"),
        actions: const [Icon(CupertinoIcons.person_crop_circle)],
      ),
      drawer: Drawer(
        backgroundColor: Colors.white,
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  DrawerHeader(
                    child: Image.asset("assets/logo.webp"),
                  ),
                  const ListTile(
                    leading: Icon(CupertinoIcons.house),
                    title: Text("Accueil"),
                  ),
                  const ListTile(
                    leading: Icon(CupertinoIcons.bubble_left_bubble_right),
                    title: Text("Forum"),
                  ),
                  const ListTile(
                    leading: Icon(Icons.celebration_outlined),
                    title: Text("Évenements"),
                  ),
                  const ListTile(
                    leading: Icon(CupertinoIcons.map),
                    title: Text("Plan interactif"),
                  ),
                  const ListTile(
                    leading: Icon(CupertinoIcons.calendar),
                    title: Text("Réservations"),
                  ),
                  const ListTile(
                    leading: Icon(CupertinoIcons.lightbulb),
                    title: Text("Infos utiles"),
                  ),
                  const ListTile(
                    leading: Icon(Icons.school_outlined),
                    title: Text("Nos apprenant ont du talent"),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: ListTile(
                leading: Icon(Icons.campaign_outlined),
                title: Text("Signaler"),
                onTap: () {
                },
              ),
            ),
          ],
        ),
      ),

      body: const Center(
        child: Column(

        ),
      ),
    );
  }
}
