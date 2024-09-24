import 'package:epsi_hub/pages/widgets/carousel_events.dart';
import 'package:epsi_hub/pages/widgets/drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? selectedLocation;

  // Liste des campus EPSI disponibles en France
  final List<String> locations = [
    'EPSI Paris',
    'EPSI Lille',
    'EPSI Lyon',
    'EPSI Bordeaux',
    'EPSI Nantes',
    'EPSI Toulouse',
    'EPSI Montpellier',
    'EPSI Arras',
    'EPSI Grenoble',
  ];

  void _showLocationModal() {
    showModalBottomSheet(
      backgroundColor: Colors.white,
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16.0),
          height: 300, // Hauteur du modal
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Sélectionner un campus EPSI',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: ListView(
                  children: locations.map((String location) {
                    return ListTile(
                      title: Text(location),
                      onTap: () {
                        setState(() {
                          selectedLocation = location;
                        });
                        Navigator.pop(context); // Ferme le modal
                      },
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

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
              Navigator.popAndPushNamed(context, '/register');
            },
          ),
        ],
      ),
      drawer: appDrawer(context),
      body: ListView(
        children: [
          Padding(padding: const EdgeInsets.only(left: 16, top: 10, bottom: 10), child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Emplacement actuel',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600], // Gris clair
                ),
              ),
              const SizedBox(height: 4),
            GestureDetector(
              onTap: _showLocationModal, // Ouvre le modal au clic
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Icon(Icons.location_on, color: Colors.red),
                  Text(
                    selectedLocation ?? 'Aucun emplacement sélectionné',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),)
            ],
          ),),
          const Padding(padding: EdgeInsets.only(left: 16), child:Text("Événements à venir", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),),
          const SizedBox(height: 10),
          CarouselSliderPub(context),
          const SizedBox(height: 10),
          const Padding(padding: EdgeInsets.only(left: 16), child:Text("Actualités", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, top: 5, bottom: 5),
            child: Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                  color: Colors.black,
                  width: 1,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 30,
                            height: 30,
                            padding: const EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.black,
                                width: 1,
                              ),
                            ),
                            child: ClipOval(
                              child: Image.asset(
                                'assets/epsi_mini_logo.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          const Text(
                            'EPSI-WIS ARRAS',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      Text(DateFormat('dd/MM/yyyy').format(DateTime.now()))
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Titre de la publication',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 2),
                  const Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum non vulputate risus, varius sodales lectus. Duis eget neque bibendum, lacinia orci ut, luctus enim. Maecenas at iaculis turpis.',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
