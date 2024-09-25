import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Drawer appDrawer(BuildContext context) {
  return Drawer(
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
                leading: const Icon(CupertinoIcons.map),
                title: const Text("Plan interactif"),
                onTap: () {
                  Navigator.popAndPushNamed(context, '/map');
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
                leading: const Icon(CupertinoIcons.exclamationmark_octagon),
                title: const Text("Vos signalements"),
                onTap: () {
                  Navigator.popAndPushNamed(context, '/signalements');
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
  );
}