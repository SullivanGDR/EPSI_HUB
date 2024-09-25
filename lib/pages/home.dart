import 'dart:convert';

import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:epsi_hub/class/actualite.dart';
import 'package:epsi_hub/class/events.dart';
import 'package:epsi_hub/class/user_class.dart';
import 'package:epsi_hub/fonctions/actualite_API.dart';
import 'package:epsi_hub/fonctions/event_API.dart';
import 'package:epsi_hub/fonctions/login_api.dart';
import 'package:epsi_hub/pages/login.dart';
import 'package:epsi_hub/pages/widgets/drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

AndroidOptions _getAndroidOptions() => const AndroidOptions(
  encryptedSharedPreferences: true,
);

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Event> _listeEvents = [];
  List<Actualite> _listeActualites = [];
  bool _isLoading = true;
  bool _isLog = false;
  User user = User(0, "_email","role", "_token", "_prenom", "_nom", "_campus");
  final storage = FlutterSecureStorage(aOptions: _getAndroidOptions());

  @override
  void initState() {
    super.initState();
    chargement();
  }

  void chargement() async {
    _listeEvents = await initListevent(_listeEvents);
    _listeActualites = await initListActu(_listeActualites);
    print(_listeEvents);
    print(_listeActualites);
    var value = await storage.read(key: "userData");
    if (value != null) {
      user = User.fromJson(jsonDecode(value));
      print(user.getCampus());
      _isLog = await isLogin(user.getToken(), user.getId());
    }
    setState(() {
      _isLoading = false;
    });
  }
  
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
      body: _isLoading
          ? const Center(
            child: CircularProgressIndicator(),
      )
          : _isLog ? _buildContent() : LoginPage(),
    );
  }

  Widget _buildContent() {
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
              if(_isLog==false) {
                Navigator.popAndPushNamed(context, '/register');
              }
            },
          ),
        ],
      ),
      drawer: appDrawer(context),
      body: Column(
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
          CarouselSlider(
            items: _listeEvents.map((event) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'EPSI-WIS ARRAS',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        event.titre,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          const Icon(CupertinoIcons.calendar, color: Colors.black, size: 20),
                          const SizedBox(width: 8),
                          Text(
                            DateFormat('d MMMM y').format(event.date),
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text(
                        event.description,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
            options: CarouselOptions(
              height: 150,
              autoPlay: true,
              viewportFraction: 1,
              autoPlayInterval: const Duration(seconds: 3),
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
              enableInfiniteScroll: true,
            ),
          ),
          const SizedBox(height: 10),
          const Padding(padding: EdgeInsets.only(left: 16), child:Text("Actualités", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),),
          const SizedBox(height: 10),
          Expanded(child: ListView.builder(
            itemCount: _listeActualites.length,
            itemBuilder: (context, index) {
              // Récupérer l'actualité actuelle
              final actualite = _listeActualites[index];

              return Padding(
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
                                    'assets/epsi_mini_logo.png', // Le logo de l'EPSI
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Text(
                                '${actualite.userNom} ${actualite.userPrenom}', // Afficher le nom de l'utilisateur
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          Text(DateFormat('dd/MM/yyyy').format(actualite.getDate())), // Afficher la date de la publication
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text(
                        actualite.getTitre(), // Afficher le titre de la publication
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        actualite.getDescription(), // Afficher la description de la publication
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),)
        ],
      ),
    );
  }
}
