import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/material.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final imageProvider = Image.asset('assets/Carte_Epsi.png').image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Image.asset("assets/logo_epsi_portal2.png", width: 230,),
      ),
      body: Center(
        child: GestureDetector(
          onTap: () {
            // Ouvrir l'image avec zoom et pan en utilisant EasyImageViewer
            showImageViewer(context, imageProvider,
                onViewerDismissed: () {
                  print("Image Viewer dismissed");
                });
          },
          child: Image.asset('assets/Carte_Epsi.png'), // Affichez un aperçu de la carte ici
        ),
      ),
    );
  }
}
