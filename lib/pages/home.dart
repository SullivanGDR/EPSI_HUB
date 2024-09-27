import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:epsi_hub/class/actualite_class.dart';
import 'package:epsi_hub/class/events_class.dart';
import 'package:epsi_hub/class/user_class.dart';
import 'package:epsi_hub/fonctions/actualite_API.dart';
import 'package:epsi_hub/fonctions/event_API.dart';
import 'package:epsi_hub/fonctions/login_api.dart';
import 'package:epsi_hub/pages/login.dart';
import 'package:epsi_hub/pages/widgets/drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
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
  // Création des listes.
  List<Event> _listeEvents = [];
  List<Actualite> _listeActualites = [];

  // Création des listes filtrées.
  List _filteredEvents = [];
  List _filteredActu = [];

  // Création de différentes variables.
  bool _isLoading = true;
  bool _isLog = false;
  User user = User(0, "_email","role", "_token", "_prenom", "_nom", "_campus");

  // Initialisation du SecureStorage.
  final storage = FlutterSecureStorage(aOptions: _getAndroidOptions());

  @override
  void initState() {
    super.initState();
    chargement();
  }

  // Fonction qui se lance au lancement de l'application
  void chargement() async {
    // Initialisations des listes d'actualités et d'événements.
    _listeEvents = await initListevent(_listeEvents);
    _listeActualites = await initListActu(_listeActualites);

    // Récupération des données de l'utilisateur stockées localement.
    var value = await storage.read(key: "userData");
    if (value != null) {
      user = User.fromJson(jsonDecode(value));
      _isLog = await isLogin(user.getToken(), user.getId());
    }

    // Filtrage des actualités et événements en fonction de l'école enregistrée
    // sur le profil de l'utilisateur connecté.
    _filtrerActuEtEventsParCampus(user.getCampus().toString());

    setState(() {
      _isLoading = false;
    });
  }

  // Liste des Campus
  final List<String> locations = [
    'EPSI Angers',
    'EPSI Auxerre',
    'EPSI Chartres',
    'EPSI Reims',
    'EPSI Rennes',
    'EPSI Saint-Etienne',
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

  // Variable qui garde en mémoire la localisation sélectionnée par l'utilisateur.
  String? selectedLocation;

  // Modal qui s'affiche pour choisir la localisation de l'utilisateur.
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
                          _filtrerActuEtEventsParCampus(location);
                        });
                        Navigator.pop(context);
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

  // Variables nécessaires pour le modal de la création d'actualité.
  final _formKeyActualite = GlobalKey<FormState>();
  String _titreActualite = '';
  String _descriptionActualite = '';

  //Modal qui apparaît lorsque l'on souhaite ajouter une actualité (uniquement disponible pour les administrateurs).
  void _modalAjoutActu(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKeyActualite,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Créer un nouveau post',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Titre',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Veuillez entrer un titre';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      setState(() {
                        _titreActualite = value!;
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Description',
                      border: OutlineInputBorder(),
                    ),
                    maxLines: 4,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Veuillez entrer une description';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      setState(() {
                        _descriptionActualite = value!;
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKeyActualite.currentState!.validate()) {
                        _formKeyActualite.currentState!.save();
                        int? campusId = (await getCampusID(user.getId()));
                        await createActu(user.getId(), _descriptionActualite, _titreActualite, campusId!);
                        Navigator.pop(context);
                        Navigator.popAndPushNamed(context, '/accueil');
                      }
                    },
                    child: const Text('Soumettre'),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // Variables nécessaires pour le modal de la création d'événements.
  final _formKeyEvent = GlobalKey<FormState>();
  String _titreEvent = '';
  String _descriptionEvent = '';
  DateTime? _selectedDateEvent;

  //Modal qui apparaît lorsque l'on souhaite ajouter un événement (uniquement disponible pour les administrateurs).
  void _modalAjoutEvent(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Form(
                key: _formKeyEvent,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Créer un nouvel événement',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Titre',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Veuillez entrer un titre';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        setState(() {
                          _titreEvent = value!;
                        });
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Description',
                        border: OutlineInputBorder(),
                      ),
                      maxLines: 4,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Veuillez entrer une description';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        setState(() {
                          _descriptionEvent = value!;
                        });
                      },
                    ),
                    const SizedBox(height: 16),
                    GestureDetector(
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2100),
                        );
                        if (pickedDate != null) {
                          setState(() {
                            _selectedDateEvent = pickedDate;
                          });
                        }
                      },
                      child: Container(
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(
                          _selectedDateEvent == null
                              ? 'Sélectionner une date'
                              : 'Date : ${DateFormat('dd/MM/yyyy').format(_selectedDateEvent!)}',
                          style: const TextStyle(fontSize: 16, color: Colors.black),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () async {
                        if (_formKeyEvent.currentState!.validate()) {
                          _formKeyEvent.currentState!.save();
                          if (_selectedDateEvent == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Veuillez sélectionner une date')),
                            );
                            return;
                          }
                          int? campusId = (await getCampusID(user.getId()));
                          await createEvent(1, _descriptionEvent, _titreEvent, campusId!, _selectedDateEvent!);
                          Navigator.pop(context);
                          Navigator.popAndPushNamed(context, '/accueil');
                        }
                      },
                      child: const Text('Soumettre'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  // Cette fonction nous permet de trier par campus les actualités et les événements à venir.
  void _filtrerActuEtEventsParCampus(String campus) {
    setState(() {
      _filteredEvents = _listeEvents.where((event) => event.campus == campus).toList();
      _filteredActu = _listeActualites.where((actualite) => actualite.campus == campus).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _isLoading
          ? const Center(
            child: CircularProgressIndicator(),
      )
          : _isLog ? _buildContent() : const LoginPage(),
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
              }else{
                Navigator.popAndPushNamed(context, '/profil');
              }
            },
          ),
        ],
      ),
      drawer: appDrawer(context,user),
      body: Column(
        children: [
          Padding(padding: const EdgeInsets.only(left: 16, top: 10, bottom: 10), child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Emplacement actuel',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 4),
              GestureDetector(
                onTap: _showLocationModal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Icon(Icons.location_on, color: Colors.red),
                    Text(
                      selectedLocation ?? user.getCampus()!,
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
            items: _filteredEvents.map((event) {
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
                      Text(
                        event.campus,
                        style: const TextStyle(
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
          const Padding(
            padding: EdgeInsets.only(left: 16),
            child:Text("Actualités",
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
              ),
            ),
          const SizedBox(height: 10),
          Expanded(child: ListView.builder(
            itemCount: _filteredActu.length,
            itemBuilder: (context, index) {
              final actualite = _filteredActu[index];

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
                                    'assets/epsi_mini_logo.png',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Text(
                                '${actualite.userNom} ${actualite.userPrenom}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          Text(DateFormat('dd/MM/yyyy').format(actualite.getDate())),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text(
                        actualite.getTitre(),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        actualite.getDescription(),
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
          ),),
        ],
      ),
      floatingActionButton: user.getRole() != 'ROLE_USER'
          ? SpeedDial(
        animatedIcon: AnimatedIcons.menu_close,
        backgroundColor: Colors.white,
        overlayColor: Colors.black,
        overlayOpacity: 0.5,
        children: [
          SpeedDialChild(
            child: Icon(Icons.article),
            backgroundColor: Colors.white,
            label: 'Créer une actualité',
            labelStyle: TextStyle(fontSize: 16.0),
            onTap: () {
              _modalAjoutActu(context);
            },
          ),
          SpeedDialChild(
            child: Icon(Icons.event),
            backgroundColor: Colors.white,
            label: 'Créer un événement',
            labelStyle: TextStyle(fontSize: 16.0),
            onTap: () {
              _modalAjoutEvent(context);
            },
          ),
        ],
      )
          : null,
    );
  }
}
