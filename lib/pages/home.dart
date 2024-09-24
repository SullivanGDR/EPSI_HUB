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
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Image.asset("assets/logo_epsi_portal2.png", width: 230,),
        actions: [
          IconButton(
            icon: const Icon(CupertinoIcons.person_crop_circle),
            color: Colors.black,
            onPressed: () {
            },
          ),
        ],
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
                    child: Image.asset("assets/logo_epsi_portal2.png"),
                  ),
                  ListTile(
                    leading: const Icon(CupertinoIcons.house),
                    title: const Text("Accueil"),
                    onTap: () {
                      Navigator.popAndPushNamed(context, '/accueil');
                    },
                  ),
                  ListTile(
                    leading: const Icon(CupertinoIcons.bubble_left_bubble_right),
                    title: const Text("Forum"),
                    onTap: () {
                      Navigator.popAndPushNamed(context, '/forum');
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.celebration_outlined),
                    title: const Text("Évenements"),
                    onTap: () {
                      Navigator.popAndPushNamed(context, '/events');
                    },
                  ),
                  ListTile(
                    leading: const Icon(CupertinoIcons.map),
                    title: const Text("Plan interactif"),
                    onTap: () {
                      Navigator.popAndPushNamed(context, '/map');
                    },
                  ),
                  ListTile(
                    leading: const Icon(CupertinoIcons.calendar),
                    title: const Text("Réservations"),
                    onTap: () {
                      Navigator.popAndPushNamed(context, '/reservations');
                    },
                  ),
                  ListTile(
                    leading: const Icon(CupertinoIcons.lightbulb),
                    title: const Text("Infos utiles"),
                    onTap: () {
                      Navigator.popAndPushNamed(context, '/infos');
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.school_outlined),
                    title: const Text("Nos apprenant ont du talent"),
                    onTap: () {
                      Navigator.popAndPushNamed(context, '/nos-apprenants');
                    },
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: ListTile(
                leading: const Icon(Icons.campaign_outlined),
                title: const Text("Signaler"),
                onTap: () {
                  Navigator.popAndPushNamed(context, '/signaler');
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
