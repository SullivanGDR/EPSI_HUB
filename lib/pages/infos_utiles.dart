import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

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
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Image
            Container(
              width: double.infinity,
              height: 270,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/epsi_exte.png'),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            SizedBox(height: 16),

            // Campus Information
            Text(
              "Bienvenue à EPSI Arras",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blue.shade900,
              ),
            ),
            SizedBox(height: 8),
            Text(
              "Le campus EPSI d'Arras est situé rue du Dépôt, à proximité de la gare. L'école offre un environnement d'apprentissage moderne pour les étudiants en ingénierie informatique, avec des équipements à la pointe de la technologie.",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),

            // Contact Information
            Text(
              "Informations de contact",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blue.shade900,
              ),
            ),
            SizedBox(height: 8),
            ListTile(
              leading: Icon(Icons.location_on, color: Colors.blue.shade900),
              title: Text("Adresse :"),
              subtitle: Text(
                  "EPSI Arras\n23-25, rue du Dépôt\n62000 Arras, France"),
            ),
            ListTile(
              leading: Icon(Icons.phone, color: Colors.blue.shade900),
              title: Text("Téléphone :"),
              subtitle: Text("03 21 71 33 34"),
            ),
            ListTile(
              leading: Icon(Icons.email, color: Colors.blue.shade900),
              title: Text("Email :"),
              subtitle: Text("info@arras-epsi.fr"),
            ),
            SizedBox(height: 16),

            // Educational Team
            Text(
              "Équipe pédagogique",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blue.shade900,
              ),
            ),
            SizedBox(height: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TeamMemberCard(
                  name: "JULIEN HOURIEZ",
                  position: "Directeur du campus",
                  email: "julien.houriez@campus-cd.com",
                  phone: "03 21 71 33 34",
                ),
                TeamMemberCard(
                  name: "JEAN MICHEL VIGNON",
                  position: "Responsable qualité / contrôle interne",
                  email: "jeanmichelvignon@campus-cd.com",
                  phone: "03 21 71 33 34",
                ),
                TeamMemberCard(
                  name: "AUDREY FOURMY",
                  position: "Responsable administrative - référente handicap",
                  email: "audrey.fourmy@campus-cd.com",
                  phone: "03 21 71 33 34",
                ),
                TeamMemberCard(
                  name: "JENNY NAWROCKI",
                  position: "Assistante polyvalente - référente handicap",
                  email: "jenny.nawrocki@campus-cd.com",
                  phone: "03 21 71 33 34",
                ),
                TeamMemberCard(
                  name: "CLEMENCE CAMISULI",
                  position: "Chargée de relations entreprises",
                  email: "clemence.camisuli@campus-cd.com",
                  phone: "03 21 71 33 34",
                ),
                TeamMemberCard(
                  name: "BRUNELLA DEVRIESE",
                  position: "Chargée de relations entreprises",
                  email: "brunella.devriese@campus-cd.com",
                  phone: "03 21 71 33 34",
                ),
                TeamMemberCard(
                  name: "FABRICE LEFEBVRE",
                  position: "Responsable pédagogique",
                  email: "fabrice.lefebvre@reseau-cd.fr",
                  phone: "03 21 71 33 34",
                ),
                TeamMemberCard(
                  name: "STEPHANE PEREZ",
                  position: "Coordinatrice pédagogique - Référente social",
                  email: "stephane.perez@campus-cd.com",
                  phone: "03 21 71 33 34",
                ),
                TeamMemberCard(
                  name: "GREGORY BOUDRINGHIN",
                  position: "Coach MyDil",
                  email: "gregory.boudringhin1@campus-cd.com",
                  phone: "03 21 71 33 34",
                ),
              ],
            ),
            SizedBox(height: 16),

            // Student Services
            Text(
              "Services étudiants",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blue.shade900,
              ),
            ),
            SizedBox(height: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  leading: Icon(Icons.local_cafe, color: Colors.blue.shade900),
                  title: Text("Réféctoire"),
                  subtitle: Text("Ouverte de 8h30 à 17h30"),
                ),
                ListTile(
                  leading: Icon(Icons.wifi, color: Colors.blue.shade900),
                  title: Text("Wi-Fi gratuit"),
                  subtitle: Text("Nom du réseau : COMDEV-PEDAGO"),
                ),
                ListTile(
                  leading:
                  Icon(Icons.computer, color: Colors.blue.shade900),
                  title: Text("Laboratoire MyDil"),
                  subtitle: Text("Accès au matériel durant les heures d'ouverture"),
                ),
              ],
            ),
            SizedBox(height: 16),

            // Local Facilities
            Text(
              "Commodités locales",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blue.shade900,
              ),
            ),
            SizedBox(height: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  leading: Icon(Icons.directions_bus, color: Colors.blue.shade900),
                  title: Text("Transports publics"),
                  subtitle: Text("Arrêt de bus à proximité : Ligne 2 - Dépôt, Ligne 6/7 : Lobbedez"),
                ),
                ListTile(
                  leading: Icon(Icons.restaurant, color: Colors.blue.shade900),
                  title: Text("Restaurants"),
                  subtitle: Text("Restaurant Universitaire d'Arras"),
                ),
              ],
            ),
            SizedBox(height: 16),

            // Map Section
            Text(
              "Localisation du campus",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blue.shade900,
              ),
            ),
            SizedBox(height: 8),
            Container(
              height: 200,
              child: Center(
                child: FlutterMap(
                  options: MapOptions(
                    initialCenter: LatLng(50.2831, 2.7789), // Center the map over London
                    initialZoom: 15,
                  ),
                  children: [
                    TileLayer( // Display map tiles from any source
                      urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png', // OSMF's Tile Server
                      userAgentPackageName: 'com.example.app',
                      maxNativeZoom: 19, // Scale tiles when the server doesn't support higher zoom levels
                      // And many more recommended properties!
                    ),
                    MarkerLayer(
                      markers: [
                        Marker(
                          point: LatLng(50.2824, 2.7766),
                          width: 80,
                          height: 80,
                          child: Icon(Icons.location_on, color: Colors.red, size: 50,),
                        ),
                      ],
                    ),
                  ],
                ),
                // Vous pouvez ajouter un widget Google Maps ici si nécessaire
              ),
            ),
            SizedBox(height: 16),

            // Footer
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Action à définir pour contacter l'école
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white, backgroundColor: Colors.blue.shade900,
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text("Contacter le campus"),
              ),
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

// Widget pour chaque membre de l'équipe pédagogique
class TeamMemberCard extends StatelessWidget {
  final String name;
  final String position;
  final String email;
  final String phone;

  TeamMemberCard({
    required this.name,
    required this.position,
    required this.email,
    required this.phone,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 4),
            Text(
              position,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey.shade700,
              ),
            ),
            SizedBox(height: 4),
            Row(
              children: [
                Icon(Icons.email, color: Colors.blue.shade900, size: 16),
                SizedBox(width: 8),
                Text(email),
              ],
            ),
            SizedBox(height: 4),
            Row(
              children: [
                Icon(Icons.phone, color: Colors.blue.shade900, size: 16),
                SizedBox(width: 8),
                Text(phone),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
