import 'package:epsi_hub/class/signalement.dart';
import 'package:epsi_hub/fonctions/signalement_API.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignalementsPage extends StatefulWidget {
  const SignalementsPage({super.key});

  @override
  State<SignalementsPage> createState() => _SignalementsPageState();
}

class _SignalementsPageState extends State<SignalementsPage> {
  List<Signalement> _listeSignalement = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    chargement();
  }

  void chargement() async {
    _listeSignalement = await initListSignalement(_listeSignalement);
    print(_listeSignalement);
    setState(() {
      _isLoading = false;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: _isLoading ? const Center(child: CircularProgressIndicator()) : _buildContent()
    );
  }

  Widget _buildContent() {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Image.asset("assets/logo_epsi_portal2.png", width: 230,),
        ),
        body: Column(
          children: [
            const Padding(padding: EdgeInsets.only(left: 16), child:Text("Vos signalements", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),),
            Expanded(
              child: ListView.builder(
                  itemCount: _listeSignalement.length,
                  itemBuilder: (context, index) {
                    final signalement = _listeSignalement[index];
                    return Padding(
                        padding: const EdgeInsets.only(left: 16, right: 16, top: 10),
                      child: Container(
                        decoration: BoxDecoration(
                          color: CupertinoColors.systemGrey5, // Couleur de fond
                          borderRadius: BorderRadius.circular(15), // Rayon pour arrondir les bords
                        ),
                        child: ListTile(
                          leading: const Icon(
                            CupertinoIcons.exclamationmark_octagon,
                            color: Colors.red, // Couleur de l'icône
                          ),
                          title: Text(
                            '${signalement.titre}',
                            style: const TextStyle(
                              color: Colors.black, // Couleur du texte du titre
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${signalement.description}',
                                style: const TextStyle(
                                  color: Colors.grey, // Couleur du texte du sous-titre
                                ),
                              ),
                              Text(
                                '${signalement.nomUser} ${signalement.prenomUser}',
                                style: const TextStyle(
                                  color: Colors.grey, // Couleur du texte du sous-titre
                                ),
                              ),
                            ],
                          ),
                          trailing: const Text(
                            "En attente",
                            style: TextStyle(
                              color: Colors.orange, // Couleur du texte de l'état
                            ),
                          ),
                        ),
                      ),
                    );
                  })
            )
          ],
        )
    );
  }
}
